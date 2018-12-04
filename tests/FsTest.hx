package;

import hxuv.*;
import haxe.io.Bytes;

@:asserts
class FsTest {
	public function new() {}
	
	public function read() {
		var loop = Loop.DEFAULT;
		var fd = loop.open('./haxelib.json', uv.Uv.FS_O_RDONLY, new Mode(6, 4, 4));
		
		var cursor = 0;
		function next() {
			var err = loop.read(fd, cursor, function(status, bytes) {
				if(bytes != null) {
					asserts.assert(status.toErrorCode() == bytes.length);
					cursor += bytes.length;
					next();
				} else {
					loop.close(fd);
					asserts.assert(status.toErrorCode() == 0);
					asserts.done();
				}
			});
			asserts.assert(!err);
		}
		next();
		
		return asserts;
	}
	
	public function readAsPipe() {
		var loop = Loop.DEFAULT;
		var fd = loop.open('./haxelib.json', uv.Uv.FS_O_RDONLY, new Mode(6, 4, 4));
		var pipe = Pipe.alloc(Loop.DEFAULT, 0);
		pipe.open(fd);
		
		var err = pipe.readStart(function(err, bytes) {
			trace(err);
			if(bytes != null) {
				asserts.assert(pipe.retainCount > 0);
				asserts.assert(bytes.length == err);
			} else if(0 == err) {
				asserts.assert(pipe.retainCount == 0);
				asserts.assert(bytes == null);
				asserts.done();
			} else {
				asserts.assert(bytes == null);
				asserts.fail(err, ErrorCode.getName(err).toString());
			}
		});
		asserts.assert(!err);
		return asserts;
	}
}