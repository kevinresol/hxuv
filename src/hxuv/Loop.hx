package hxuv;

import cpp.*;

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
}