package hxuv;

@:enum
extern abstract RunMode(uv.Uv.RunMode) to Int {
	@:native('UV_RUN_DEFAULT') var DEFAULT;
	@:native('UV_RUN_ONCE') var ONCE;
	@:native('UV_RUN_NOWAIT') var NOWAIT;
}