package hxuv;

import uv.Uv;
import cpp.*;

class Tcp extends Stream {
	public var tcp(default, null):uv.Tcp;
	
	function new(tcp:uv.Tcp) {
		super(tcp);
		this.tcp = tcp;
	}
	
	public static function alloc(?loop:uv.Loop) {
		var handle = new uv.Tcp();
		handle.init(loop == null ? uv.Loop.DEFAULT : loop);
		return new Tcp(handle);
	}
	
	public static function retrieve(handle:uv.Tcp) {
		switch Std.instance((handle.getData():Tcp), Tcp) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: return v;
		}
	}
	
	public function connect(ip, port, cb:Int->Void) {
		var req = Connect.alloc(this);
		var addr = new uv.SockAddrIn(); // TODO: possible to do a stack allocation here?
		addr.ip4Addr(ip, port);
		var result = tcp.connect(req.connect, addr, Callable.fromStaticFunction(onConnect));
		if(result == 0) {
			retain();
			req.retain();
			req.data = cb;
		}
		addr.destroy(); 
		return result;
	}
	
	public function bind(ip, port, flags) {
		var addr = new uv.SockAddrIn(); // TODO: possible to do a stack allocation here?
		addr.ip4Addr(ip, port);
		var result = tcp.bind(addr, flags);
		addr.destroy();
		return result;
	}
	
	override function finalize() {
		if(tcp != null) {
			tcp.destroy();
			cleanup();
		}
	}
	
	override function createClient():Stream {
		return alloc();
	}
	
	override function cleanup() {
		super.cleanup();
		tcp = null;
	}
	
	static function onConnect(req:RawPointer<Connect_t>, status:Int) {
		var connect = Connect.retrieve(req);
		var cb:Int->Void = connect.data;
		cb(status);
	}
}