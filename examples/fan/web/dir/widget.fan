using web
using webapp

class TestWidget: Widget
{
  override Void doGet()
  {
    head.title("Title It Up!")
    body.h1("Does this thing work?")

    body.table("border='1' cellpadding='5'")
    body.tr.td.w("uri").tdEnd.td.w(req.uri).tdEnd.trEnd
    body.tr.td.w("type").tdEnd.td.w(type.qname).tdEnd.trEnd
    body.tableEnd

    body.form("method='post' action='${req.uri}?action=foo'")
    body.p
    body.submit("value='Invalid Action'")
    body.pEnd
    body.formEnd

    actionForm(&foo)
    body.p
    body.submit
    body.pEnd
    body.formEnd
    body.p.w("Back up to").a(`/dir/index.html`).w("/dir/index.html").aEnd.w(".").pEnd
  }

  Void foo()
  {
    echo("TestWidget.foo uri=$req.uri")
    res.redirect(`/dir/widget.fan`)
  }

}