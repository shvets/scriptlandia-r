// defining a trait in Scala

trait Emptiness {
  def isEmpty: Boolean = size == 0;

  def size: int;
}

trait Guard {
}

class AbstractSet {
}

// compose using traits
class IntSet extends AbstractSet with Emptiness with Guard {
  def size: int = 0;
}