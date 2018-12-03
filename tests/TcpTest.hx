package;

import hxuv.*;
import haxe.io.Bytes;

@:asserts
class TcpTest {
	public function new() {}
	
	public function client() {
		var tcp = Tcp.alloc();
		var err = tcp.connect('93.184.216.34', 80, function(err) {
			asserts.assert(!err);
			var err = tcp.write(Bytes.ofString('GET / HTTP/1.1\r\nHost: example.com\r\nConnection: close\r\n\r\n'), function(err) {
				asserts.assert(!err);
			});
			asserts.assert(tcp.retainCount > 0);
			asserts.assert(!err);
			var err = tcp.readStart(function(err, bytes) {
				trace(err, err.isError());
				if(!err.isError()) {
					asserts.assert(tcp.retainCount > 0);
					asserts.assert(bytes.length == err);
				} else if(err.toErrorCode() == ErrorCode.EOF) {
					asserts.assert(tcp.retainCount == 0);
					asserts.assert(bytes == null);
					asserts.done();
				} else {
					asserts.assert(bytes == null);
					asserts.fail(err, ErrorCode.getName(err).toString());
				}
			});
			asserts.assert(tcp.retainCount > 0);
			asserts.assert(!err);
		});
		
		asserts.assert(!err);
		return asserts;
	}
	
	public function server() {
		var server = Tcp.alloc();
		var err = server.bind('0.0.0.0', 7000, 0);
		asserts.assert(!err);
		
		server.listen(128, function(_) {
			var client = Tcp.alloc();
			server.accept(client);
			asserts.assert(!err);
			
			var err = client.readStart(function(err, bytes) {
				if(!err.isError()) {
					client.write(bytes, function(_) {});
				} else if(err.toErrorCode() == ErrorCode.EOF) {
					client.close(function() {});
				} else {
					trace(ErrorCode.getName(err));
				}
			});
			asserts.assert(!err);
		});
		
		var tcp = Tcp.alloc();
		tcp.connect('127.0.0.1', 7000, function(err) {
			asserts.assert(!err);
			
			var err = tcp.write(Bytes.ofString('Hello World!'), function(_) {});
			tcp.shutdown(function(err) {});
			asserts.assert(!err);
			
			var err = tcp.readStart(function(err, bytes) {
				if(!err.isError()) {
					asserts.assert(bytes.toString() == 'Hello World!');
				} else {
					asserts.assert(err.toErrorCode() == ErrorCode.EOF);
					asserts.done();
				}
			});
			asserts.assert(!err);
		});
		
		return asserts;
	}
}