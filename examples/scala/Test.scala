// define an abstract class for the iterator construct

abstract class AbsIterator {
    type T;
    def hasNext: boolean;
    def next: T;
}

// enrich iterators with an additional construct foreach

trait RichIterator extends AbsIterator {
    def foreach(f: T => unit): unit =
    while (hasNext) f(next);
}

// yet another iterator for Strings
// provides concrete implementations for all abstract
// methods inherited

class StringIterator(s: String) extends AbsIterator {
    type T = char;
    private var i = 0;
    def hasNext = i < s.length();
    def next = { val x = s.charAt(i); i = i + 1; x }
}

// usage
// composition of StringIterator with RichIterator
// Using class inheritance along with trait inheritance
// without considerations for multiple definitions
// : only delta is inherited

object Test {
  def main(args: Array[String]): unit = {
    class Iter extends StringIterator(args(0)) with RichIterator;

    val iter = new Iter;

    iter foreach System.out.println
  }
}

Test.main(args)