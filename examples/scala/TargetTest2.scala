//

object TargetTest2 extends Application {
  def loop(body: => Unit): LoopUnlessCond =
    new LoopUnlessCond(body)

  protected class LoopUnlessCond(body: => Unit) {
    def unless(cond: => Boolean): Unit = {
      body
      if (!cond) unless(cond)
    }
  }
  var i = 10

  loop {
    Console.println("i = " + i)
    i = i - 1
  } unless (i == 0)
}

TargetTest2.main(args)