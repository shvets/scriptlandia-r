//

class Person(ln : String, fn : String, s : Person) {
  def lastName = ln;
  def firstName = fn;
  def spouse = s;

  def this(ln : String, fn : String) = { this(ln, fn, null); }

  private def isMarried() = {spouse != null;}

  def computeTax(income: double) : double = {
      if (isMarried()) income * 0.20
      else income * 0.30
  }

  override def toString() =
      "Hi, my name is " + firstName + " " + lastName +
      (if (spouse != null) " and this is my spouse, " + spouse.firstName + " " + spouse.lastName + "." else ".");
}