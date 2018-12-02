package hxuv;

import uv.Uv;
import cpp.*;

class Timer extends Handle {
	public var timer(default, null):uv.Timer;
	
	var timer_cb:Void->Void;
	
	function new(timer:uv.Timer) {
		super(timer);
		this.timer = timer;
	}
	
	public static function alloc(?loop:uv.Loop) {
		var handle = new uv.Timer();
		handle.init(loop == null ? uv.Loop.DEFAULT : loop);
		return new Timer(handle);
	}
	
	public static function retrieve(handle:uv.Timer, release = true) {
		switch Std.instance((handle.getData():Timer), Timer) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: 
				if(release) v.release();
				return v;
		}
	}
	
	public inline function start(cb, timeout, repeat) {
		var result = timer.start(Callable.fromStaticFunction(onTimer), timeout, repeat);
		if(result == 0) timer_cb = cb;
		return result;
	}
	
	public inline function stop() {
		release();
		timer.stop();
	}
	
	function set_timer_cb(v) {
		if(timer_cb == null && v != null) retain();
		if(timer_cb != null && v == null) release();
		return timer_cb = v;
	}
	
	override function finalize() {
		if(timer != null) {
			timer.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		timer = null;
	}
	
	static function onTimer(handle:RawPointer<Timer_t>):Void {
		var timer = hxuv.Timer.retrieve(handle, false);
		timer.timer_cb();
	}
	
}