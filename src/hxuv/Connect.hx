package hxuv;

import uv.Uv;
import cpp.*;

@:allow(hxuv)
class Connect extends Req {
	public var connect(default, null):uv.Connect;
	public var stream(default, null):Stream;
	
	function new(connect:uv.Connect, stream) {
		super(connect);
		this.connect = connect;
		this.stream = stream;
	}
	
	static function alloc(stream) {
		return new Connect(new uv.Connect(), stream);
	}
	
	public static function retrieve(handle:uv.Connect, release = true) {
		switch Std.instance((handle.getData():Connect), Connect) {
			case null: throw 'No wrapper instance is stored in this handle';
			case v: 
				if(release) {
					v.release();
					v.stream.release();
				}
				return v;
		}
	}
	
	override function finalize() {
		if(connect != null) {
			connect.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		connect = null;
	}
}