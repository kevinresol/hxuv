package hxuv;

import uv.Uv;
import cpp.*;

class Req extends Base {
	public var req(default, null):uv.Req;
	
	function new(req) {
		super();
		this.req = req;
		req.setData(this);
	}
	
	public static function alloc() {
		return new Req(new uv.Req());
	}
	
	public static function retrieve(req:uv.Req) {
		switch Std.instance((req.getData():Req), Req) {
			case null: throw 'No wrapper instance is stored in this req';
			case v: return v;
		}
	}
	
	override function finalize() {
		if(req != null) {
			req.destroy();
			cleanup();
		}
	}
	
	override function cleanup() {
		super.cleanup();
		req = null;
	}
}