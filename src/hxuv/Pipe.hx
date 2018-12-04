package hxuv;

import uv.Uv;
import cpp.*;

class Pipe extends Stream {
	public var pipe(default, null):uv.Pipe;
	
	function new(pipe:uv.Pipe) {
		super(pipe);
		this.pipe = pipe;
	}
	
	public static function alloc(?loop:Loop, ipc:Int) {
		var handle = new uv.Pipe();
		if(loop == null) loop = Loop.DEFAULT;
		handle.init(loop.loop, ipc);
		return new Pipe(handle);
	}
	
	public static function retrieve(handle:uv.Pipe) {
		switch Std.instance((handle.getData():Pipe), Pipe) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: return v;
		}
	}
	
	public inline function open(file:Int):Status { // TODO: make sure fd is always int on every OS
		return pipe.open(file);
	}
	
	override function finalize() {
		if(pipe != null) {
			pipe.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		pipe = null;
	}
}