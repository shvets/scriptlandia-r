//print new File(".").getAbsolutePath();

//File.setCurrentDirectory("D:/Work/Scriptlandia-4/projects/examples/src/main/groovy/xmltest2.groovy");


inventoryXML = new XmlParser().parse("inventory.xml")
 
for (section in inventoryXML) {
        println "Section: " + section['@name']
        for(book in section) {
                println book['@title'] + " by " + book['@author']
                if (book.text() != "")
                        println "Content: " + book.text()
        }
}
