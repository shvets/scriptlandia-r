import groovy.swing.SwingBuilder 
import javax.swing.JFileChooser 
import javax.swing.WindowConstants as WC 
 
class Dependency { 
  String org 
  String name 
  String rev 
} 
 
swing = SwingBuilder.build { 
  frame(id:'f', title: "Maven To Ivy", pack: true, show: true,  
        defaultCloseOperation: WC.EXIT_ON_CLOSE) { 
    panel(id: 'p') { 
      tableLayout { 
        tr { 
          td { 
            button(text: 'Select Pom File', actionPerformed: { 
              fc = new JFileChooser() 
              if (fc.showDialog(null, 'Select Pom') == JFileChooser.APPROVE_OPTION) { 
                processPom(fc.getSelectedFile()) 
              } 
            }) 
          } 
        } 
        tr { 
          td { 
            scrollPane() { 
              textArea(id:'output', rows:10, columns:50) 
            } 
          } 
        } 
        tr { 
          td { 
            checkBox(text:'Append', id:'append') 
          } 
        } 
      } 
    } 
  } 
} 
 
def processPom(pomFile) { 
 
  def project = new XmlSlurper().parse(pomFile); 
  def list = [] 
  project.dependencies.dependency.each { 
    def dep = new Dependency(org: it.groupId, name: it.artifactId, rev: it.version); 
    list << dep 
  } 
  def writer = new StringWriter(); 
  def xml = new groovy.xml.MarkupBuilder(writer) 
  xml.dependencies { 
    list.each {d -> 
      dependency(org: d.org, name: d.name, rev: d.rev) 
    } 
  } 
  if (swing.append.selected) { 
    swing.output.append(writer.toString())  
  }else{ 
    swing.output.text = writer.toString() 
  } 
}
