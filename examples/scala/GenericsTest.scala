object GenericsTest extends Application {

  abstract class Sum[t] {
    def add(x: t, y: t): t;
  }

  object intSum extends Sum[Int] {
    def add(x: Int, y: Int): Int = x + y;
  }

  class ListSum[a] extends Sum[List[a]] {
    def add(x : List[a], y : List[a]) : List[a] = x ::: y;
  }

  val s = new ListSum().add(List("a", "b"), List("c", "d"));
  val t = new ListSum().add(List(1, 2), List(3, 4));
  Console.println(s);
  Console.println(t);
}

GenericsTest.main(args);