//

import scala.xml.{ Node, XML, PrettyPrinter } ;

object XmlTest2 {
  def main(args: Array[String]): unit = {
    val mustangFeatures =
      <feature-list>
        <release>Mustang</release>
        <feature>
          <id>29</id>
          <name>Method to find free disk space</name>
          <engineer>iris.garcia</engineer>
          <state>approved</state>
        </feature>
        <feature>
          <id>201</id>
          <name>Improve painting (fix gray boxes)</name>
          <engineer>scott.violet</engineer>
          <state>approved</state>
        </feature>
        <feature>
          <id>42</id>
          <name>Zombie references</name>
          <engineer>mark.reinhold</engineer>
          <state>rejected</state>
        </feature>
      </feature-list>;

    def isOpen(ft: Node): Boolean = {
      if ((ft \ "state").text.equals("approved"))
        false
      true
    }

    def rejectOpen(doc: Node): Node = {

      def rejectOpenFeatures(features: Iterator[Node]): List[Node] = {
        for(val ft <- features) yield ft match {

          case x @ <feature>{ f @ _ * }</feature> if isOpen(x.elements.next) =>
            <feature>
            <id>{(x.elements.next \ "id").text}</id>
            <name>{(x.elements.next \ "name").text}</name>
            <engineer>{(x.elements.next \ "engineer").text}</engineer>
            <state>rejected</state>
          </feature>

          case _ => ft
        }
      }.toList;

      doc match {
        case <feature-list>{ fts @ _ * }</feature-list> =>
          <feature-list>{ rejectOpenFeatures(fts.elements) }</feature-list>
      }
    }

    val pp = new PrettyPrinter( 80, 5 );

    Console.println(pp.format(rejectOpen(mustangFeatures)));
  }

}

XmlTest2.main(args)
