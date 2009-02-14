//

import scala.xml.{ Node, XML } ;

object XmlTest {
  def main(args: Array[String]): unit = {

    val mustang =
      <feature>
        <id>29</id>
        <name>Method to find free disk space</name>
        <engineer>iris.garcia</engineer>
        <state>approved</state>
      </feature>;

    def addReviewer(feature: Node, user: String, time: String): Node =
      feature match {
        case <feature>{ cs @ _* }</feature> =>
          <feature>{ cs }<reviewed>
          <who>{ user }</who>
          <when>{ time }</when>
          </reviewed></feature>
      }

    Console.println(addReviewer(mustang,
            "graham.hamilton",
            "2004-11-07T13:44:25.000-08:00"));
  }

}

XmlTest.main(args)