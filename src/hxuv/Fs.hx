package hxuv;

import uv.Uv;
import cpp.*;

@:allow(hxuv)
class Fs extends Req {
	public var fs(default, null):uv.Fs;
	public var result(get, never):Int;
	inline function get_result() return fs.result;
	
	function new(fs:uv.Fs) {
		super(fs);
		this.fs = fs;
	}
	
	public static function alloc() {
		return new Fs(new uv.Fs());
	}
	
	public static function retrieve(handle:uv.Fs, release = true) {
		switch Std.instance((handle.getData():Fs), Fs) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: 
				if(release) v.release();
				return v;
		}
	}
	
	
	override function finalize() {
		if(fs != null) {
			fs.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		fs = null;
	}
	
}