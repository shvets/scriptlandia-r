import groovy.xml.MarkupBuilder

builder = new MarkupBuilder()

builder.cars() {
  car(year:2001, color:'red') {
    make("Honda")
    model("Accord")
  }

  car(year:2004, color:'white') {
    make("Audi")
    model("AllRoad")
  }

}
