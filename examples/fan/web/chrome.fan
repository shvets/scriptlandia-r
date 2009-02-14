using web
using webapp

class TestChrome : Widget
{
  override Void doGet()
  {
    body.h1("This is chromed baby!")
    body.div("style='padding:10px; border:1px solid red;'")
    view := req.stash["webapp.chromeView"] as Widget
    view.service
    body.divEnd
  }
}