import groovy.xml.MarkupBuilder

builder = new MarkupBuilder()

builder.html() {
  head() {
    title("Some title")
  }

  body() {
    title("Some body")
  }
}
