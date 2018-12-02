package hxuv;

import uv.Uv;

class RunMode {
	public static var DEFAULT(get, never):Int; static inline function get_DEFAULT() return Uv.RUN_DEFAULT;
	public static var ONCE(get, never):Int; static inline function get_ONCE() return Uv.RUN_ONCE;
	public static var NOWAIT(get, never):Int; static inline function get_NOWAIT() return Uv.RUN_NOWAIT;
}