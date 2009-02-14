// http://debasishg.blogspot.com/2008/06/scala-to-java-smaller-inheritance.html

case class Employee(id: Int) { def salary: Int = id }
case class DailyWorker(id: Int) { def salary: Int = id }
case class Contractor(id: Int) { def wage: Int = id }

case class Salaried(salary: Int)
implicit def wageToSalary(in: {def wage: Int}) = Salaried(in.wage)

class Payroll {
  def makeSalarySheet[T <% { def salary: Int }](emps: List[T]) = {
    (0 /: emps)(_ + _.salary)
  }
}

val l = List[{ def salary: Int }](DailyWorker(1), Employee(2), Employee(1), Contractor(9))
val p = new Payroll
println(p.makeSalarySheet(l))
