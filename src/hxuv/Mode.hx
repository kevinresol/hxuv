package hxuv;

abstract Mode(Int) from Int to Int {
	public inline function new(root, group, user) {
		this = root << 6 | group << 3 | user;
	}
}

