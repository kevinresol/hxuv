package hxuv;

typedef StatusCode = #if lua String #else Int #end ;

abstract Status(StatusCode) from StatusCode to StatusCode {
	
	#if lua
		
	@:to public inline function isError():Bool
		return this != null;
	
	@:to public inline function toErrorCode():Int
		return this == null ? 0 : -1; // TODO: reverse err string to code
		
	@:to public inline function toErrorName()
		return this;
	
	#else
		
	@:to public inline function isError():Bool
		return this < 0;
	
	@:to public inline function toErrorCode():Int
		return this;
	
	@:to public inline function toErrorName():String
		return this >= 0 ? null : ErrorCode.getName(this);
	
	#end
	
	public inline function is(err:ErrorCode)
		return this == err;
	
	
	@:op(!A)
	public inline function isOk():Bool return !isError();
	
	// @:op(A != B) @:commutative
	// public static inline function neq(a:Status, b:Int):Bool return a.toStatusCode() != b;
	// @:op(A == B) @:commutative
	// public static inline function eq(a:Status, b:Int):Bool return a.toStatusCode() == b;
	// @:op(A > B)
	// public static inline function gt_lhs(a:Status, b:Int):Bool return a.toStatusCode() > b;
	// @:op(A < B)
	// public static inline function lt_lhs(a:Status, b:Int):Bool return a.toStatusCode() > b;
	// @:op(A >= B)
	// public static inline function gte_lhs(a:Status, b:Int):Bool return a.toStatusCode() >= b;
	// @:op(A <= B)
	// public static inline function lte_lhs(a:Status, b:Int):Bool return a.toStatusCode() <= b;
	// @:op(A > B)
	// public static inline function gt_rhs(a:Int, b:Status):Bool return a > b.toStatusCode();
	// @:op(A < B)
	// public static inline function lt_rhs(a:Int, b:Status):Bool return a > b.toStatusCode();
	// @:op(A >= B)
	// public static inline function gte_rhs(a:Int, b:Status):Bool return a >= b.toStatusCode();
	// @:op(A <= B)
	// public static inline function lte_rhs(a:Int, b:Status):Bool return a <= b.toStatusCode();
}