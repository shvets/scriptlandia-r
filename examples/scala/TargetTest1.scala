//

object TargetTest1 extends Application {
  def whileLoop(cond: => Boolean) (body: => Unit): Unit =
    if (cond) {
      body
      whileLoop(cond)(body)
    }

  var i = 10

  whileLoop (i > 0) {
    Console.println(i)
    i = i - 1
  }

}

TargetTest1.main(args)