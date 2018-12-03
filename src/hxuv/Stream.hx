package hxuv;

import uv.Uv;
import cpp.*;
import haxe.io.Bytes;

class Stream extends Handle {
	public var stream(default, null):uv.Stream;
	
	var read_cb(default, set):Status->Bytes->Void;
	var connection_cb(default, set):Stream->Void;
	
	function new(stream:uv.Stream) {
		super(stream);
		this.stream = stream;
	}
	
	public static function alloc() {
		return new Stream(new uv.Stream());
	}
	
	public static function retrieve(handle:uv.Stream, release = true) {
		switch Std.instance((handle.getData():Stream), Stream) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: 
				if(release) v.release();
				return v;
		}
	}
	
	public function shutdown(cb:Status->Void):Status {
		var req = Shutdown.alloc(this);
		req.data = cb;
		var result = stream.shutdown(req.shutdown, Callable.fromStaticFunction(onShutdown));
		if(result == 0) {
			retain();
			req.retain();
		}
		return result;
	}
	
	public function listen(backlog, cb):Status {
		var result = stream.listen(backlog, Callable.fromStaticFunction(onConnection));
		if(result == 0) connection_cb = cb;
		return result;
	}
	
	public inline function accept(client:Stream):Status
		return stream.accept(client.stream);
		
	public function readStart(cb):Status {
		var result = stream.readStart(Callable.fromStaticFunction(onAlloc), Callable.fromStaticFunction(onRead));
		if(result == 0) read_cb = cb;
		return result;
	}
	
	public function readStop():Status {
		read_cb = null;
		return stream.readStop();
	}
	
	public function write(bytes:Bytes, cb:Status->Void):Status {
		var buf = new uv.Buf();
		buf.alloc(bytes.length);
		buf.copyFromBytes(bytes, bytes.length);
		var req = Write.alloc(this, buf);
		req.data = cb;
		var result = stream.write(req.write, buf, 1, Callable.fromStaticFunction(onWrite));
		if(result == 0) {
			retain();
			req.retain();
		}
		return result;
	}
		
	public inline function isWritable():Bool
		return stream.isWritable();
		
	public inline function isReadable():Bool
		return stream.isReadable();
	
	override function finalize() {
		if(stream != null) {
			stream.destroy();
			cleanup();
		}
	}
	
	function createClient():Stream {
		return alloc();
	}
	
	override function cleanup() {
		super.cleanup();
		stream = null;
	}
	
	static function onShutdown(req:RawPointer<Shutdown_t>, status:Int) {
		var shutdown = Shutdown.retrieve(req);
		var cb:Status->Void = shutdown.data;
		cb(status);
	}
	
	function set_read_cb(v) {
		if(read_cb == null && v != null) retain();
		if(read_cb != null && v == null) release();
		return read_cb = v;
	}
	
	function set_connection_cb(v) {
		if(connection_cb == null && v != null) retain();
		if(connection_cb != null && v == null) release();
		return connection_cb = v;
	}
	
	static function onConnection(stream:RawPointer<Stream_t>, status:Int) {
		var stream = Stream.retrieve(stream, false);
		var client = stream.createClient();
		stream.connection_cb(client);
	}
	
	static function onAlloc(handle:RawPointer<Handle_t>, size:SizeT, buf:RawPointer<Buf_t>) {
		uv.Buf.fromRaw(buf).alloc(size);
	}
	
	static function onRead(handle:RawPointer<Stream_t>, nread:SSizeT, buf:RawConstPointer<Buf_t>) {
		var stream = Stream.retrieve(handle, false);
		var buf = uv.Buf.unmanaged(buf);
		var nread:Int = nread;
		if(nread > 0) {
			var bytes = Bytes.alloc(nread);
			buf.copyToBytes(bytes, nread);
			stream.read_cb(nread, bytes);
		} else {
			stream.release();
			stream.read_cb(nread, null);
			stream.read_cb = null;
		}
		buf.free();
	}
	
	static function onWrite(handle:RawPointer<Write_t>, status:Int) {
		var write = Write.retrieve(handle);
		var cb:Status->Void = write.data;
		cb(status);
	}
}