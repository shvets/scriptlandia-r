import groovy.swing.SwingBuilder

def swingBuilder = new SwingBuilder()
def widget = swingBuilder.frame(title:'My Frame', defaultCloseOperation:javax.swing.WindowConstants.EXIT_ON_CLOSE) {
    panel() {
          label(text:"label")
          textField(text:"text")

       button(text:'OK', actionPerformed:{ println("I've been clicked with event ${it}") })
    }
}

widget.setSize(200, 100);

widget.show()
