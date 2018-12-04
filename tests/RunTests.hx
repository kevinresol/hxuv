package ;

import tink.unit.*;
import tink.testrunner.*;

class RunTests {

  static function main() {
    Runner.run(TestBatch.make([
      new TimerTest(),
      new TcpTest(),
    ])).handle(Runner.exit);
    
    hxuv.Loop.DEFAULT.run(DEFAULT);
  }
  
}