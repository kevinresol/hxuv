package hxuv;

import uv.Uv;
import cpp.*;
import haxe.io.Bytes;

class Loop extends Base {
	public var loop(default, null):uv.Loop;
	
	public static var DEFAULT(default, null):Loop = new Loop(uv.Loop.DEFAULT);
	
	function new(loop) {
		super();
		this.loop = loop;
		loop.setData(this);
	}
	
	public static function alloc() {
		return new Loop(new uv.Loop());
	}
	
	public static function retrieve(loop:uv.Loop) {
		switch Std.instance((loop.getData():Loop), Loop) {
			case null: throw 'No wrapper instance is stored in this loop';
			case v: return v;
		}
	}
	
	@:unreflective
	public inline function run(mode:RunMode)
		return loop.run(mode);
		
	
	// fs
	
	public inline function open(path, flags, mode):Status {
		var req = Fs.alloc();
		return loop.open(req.fs, path, flags, mode, null);
	}
		
	public inline function close(file):Status {
		var req = Fs.alloc();
		return loop.close(req.fs, file, null);
	}
	
	public inline function read(file, offset, cb:Status->Bytes->Void):Status {
		var buf = new uv.Buf();
		buf.alloc(0xffff);
		var req = Fs.alloc();
		req.retain();
		req.data = {
			cb: cb,
			buf: buf,
		}
		return loop.read(req.fs, file, buf, 1, offset, Callable.fromStaticFunction(onRead));
	}
	
	override function finalize() {
		if(loop != null) {
			loop.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		loop = null;
	}
	
	static function onRead(req:RawPointer<Fs_t>) {
		var req = Fs.retrieve(req);
		var ctx:{
			cb:Status->Bytes->Void,
			buf:uv.Buf,
		 } = req.data;
		
		var result:Int = req.result;
		var buf = ctx.buf;
		var cb = ctx.cb;
		if(result > 0) {
			var bytes = Bytes.alloc(result);
			buf.copyToBytes(bytes, result);
			cb(result, bytes);
		} else {
			cb(result, null);
		}
		buf.destroy();
	}
}