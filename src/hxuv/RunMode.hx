package hxuv;

@:enum
extern abstract RunMode(Int) to Int {
	@:native('UV_RUN_DEFAULT') var DEFAULT;
	@:native('UV_RUN_ONCE') var ONCE;
	@:native('UV_RUN_NOWAIT') var NOWAIT;
}