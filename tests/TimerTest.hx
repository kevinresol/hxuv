package;

import haxe.Timer;

@:asserts
class TimerTest {
  public function new() {}
  public function delay() {
    var start = Timer.stamp();
    asserts.assert(start >= 0);
    Timer.delay(function() {
      var now = Timer.stamp();
      var dt = now - start;
      asserts.assert(dt > 0.99); // well, there might be a slight difference
      asserts.assert(Math.round(dt) == 1.0);
      asserts.done();
    }, 1000);
    return asserts;
  }
}