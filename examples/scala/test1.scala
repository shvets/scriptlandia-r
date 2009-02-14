val numbers = Array(1, 2, 3, 4, 5)
val sum1 = numbers.reduceLeft((a:Int, b:Int) => a + b)
 
println("The sum of the numbers one through five is " + sum1)

val sum2 = numbers.reduceLeft[Int](_ + _)
 
println("The sum of the numbers one through five is " + sum2)

val sum3 = numbers.foldLeft(0)(_ + _)
 
println("The sum of the numbers one through five is " + sum3)
