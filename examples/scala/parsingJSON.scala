// http://www.hvergi.net/2008/06/parsing-json-with-scala

import scala.util.parsing.combinator._
import java.io.FileReader 

class JSON extends JavaTokenParsers { 
        def obj: Parser[Map[String, Any]] = 
                "{"~> repsep(member, ",") <~"}" ^^ (Map() ++ _) 
 
        def arr: Parser[List[Any]] = 
                "["~> repsep(value, ",") <~"]" 
 
        def member: Parser[(String, Any)] = 
                stringLiteral~":"~value ^^ 
                        { case name~":"~value => (name, value) } 
 
        def value: Parser[Any] = ( 
                obj 
                | arr 
                | stringLiteral 
                | floatingPointNumber ^^ (_.toInt) 
                | "null" ^^ (x => null) 
                | "true" ^^ (x => true) 
                | "false" ^^ (x => false) 
                ) 
}
 
object JSONTest extends JSON { 
        def main(args: Array[String]) { 
                val reader = new FileReader(/*args(0)*/"test.json") 
                println(parseAll(value, reader)) 
        } 
}

JSONTest.main(args);
