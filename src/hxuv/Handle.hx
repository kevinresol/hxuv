package hxuv;

import uv.Uv;
import cpp.*;

class Handle extends Base {
	public var handle(default, null):uv.Handle;
	
	function new(handle) {
		super();
		this.handle = handle;
		handle.setData(this);
	}
	
	public static function alloc() {
		return new Handle(new uv.Handle());
	}
	
	public static function retrieve(handle:uv.Handle) {
		switch Std.instance((handle.getData():Handle), Handle) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: return v;
		}
	}
	
	public inline function close(cb) handle.close(cb);
	public inline function isClosing() return handle.isClosing();
	
	override function finalize() {
		if(handle != null) {
			handle.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		handle = null;
	}
}