# hxuv

libuv bindings for Haxe

# Supported targets

- C++, requires the [`linc_uv`](https://github.com/kevinresol/linc_uv) library

(possible to support other targets in the future)

# Example

```haxe
// create a echo tcp server
var server = Tcp.alloc();
server.bind('0.0.0.0', 7000, 0);
server.listen(128, function(_) {
	var client = Tcp.alloc();
	server.accept(client);
	client.readStart(function(status, bytes) {
		if(bytes != null) client.write(bytes, function(_) trace('echoed')); // echo
		else client.close(function() trace('closed')); // client ended
	});
});

// connect to the server, send a string and print the echo from server
var tcp = Tcp.alloc();
tcp.connect('127.0.0.1', 7000, function(status) {
	tcp.write(Bytes.ofString('Hello World!'), function(_) trace('written')); // write to server
	tcp.shutdown(function(status) trace('shutdown')); // close the outgoing stream
	tcp.readStart(function(status, bytes) {
		if(bytes != null) trace(bytes.toString());
		else tcp.close(function() trace('closed')); // close the tcp socket
	});
});
```