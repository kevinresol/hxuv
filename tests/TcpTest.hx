package;

import hxuv.*;
import haxe.io.Bytes;

@:asserts
class TcpTest {
	public function new() {}
	
	public function client() {
		var tcp = Tcp.alloc();
		var r = tcp.connect('93.184.216.34', 80, function(status) {
			asserts.assert(status == 0);
			var r = tcp.write(Bytes.ofString('GET / HTTP/1.1\r\nHost: example.com\r\nConnection: close\r\n\r\n'), function(status) {
				asserts.assert(status == 0);
			});
			asserts.assert(tcp.retainCount > 0);
			asserts.assert(r == 0);
			var r = tcp.readStart(function(status, bytes) {
				if(status > 0) {
					asserts.assert(tcp.retainCount > 0);
					asserts.assert(bytes.length == status);
				} else if(status == ErrorCode.EOF) {
					asserts.assert(tcp.retainCount == 0);
					asserts.assert(bytes == null);
					asserts.done();
				} else {
					asserts.assert(bytes == null);
					asserts.fail(status, ErrorCode.getName(status).toString());
				}
			});
			asserts.assert(tcp.retainCount > 0);
			asserts.assert(r == 0);
		});
		
		asserts.assert(r == 0);
		return asserts;
	}
	
	public function server() {
		var server = Tcp.alloc();
		var r = server.bind('0.0.0.0', 7000, 0);
		asserts.assert(r == 0);
		
		server.listen(128, function(_) {
			var client = Tcp.alloc();
			server.accept(client);
			asserts.assert(r == 0);
			
			var r = client.readStart(function(status, bytes) {
				if(status > 0) {
					client.write(bytes, function(_) {});
				} else if(status == ErrorCode.EOF) {
					client.close(function() {});
				} else {
					trace(ErrorCode.getName(status));
				}
			});
			asserts.assert(r == 0);
		});
		
		var tcp = Tcp.alloc();
		tcp.connect('127.0.0.1', 7000, function(status) {
			asserts.assert(status == 0);
			
			var r = tcp.write(Bytes.ofString('Hello World!'), function(_) {});
			tcp.shutdown(function(status) {});
			asserts.assert(r == 0);
			
			var r = tcp.readStart(function(status, bytes) {
				if(status > 0) {
					asserts.assert(bytes.toString() == 'Hello World!');
				} else {
					asserts.assert(status == ErrorCode.EOF);
					asserts.done();
				}
			});
			asserts.assert(r == 0);
		});
		
		return asserts;
	}
}