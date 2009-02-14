#! /usr/bin/env fan
//
// Copyright (c) 2007, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 Mar 08  Brian Frank  Creation
//

using fand
using webapp
using wisp
using sql
using haven

**
** Boot script for fand demo
**
class Boot : BootScript
{
  override Thread[] services :=
  [
    WispService.make("web")
    {
      port = 8080
      pipeline =
      [
        FindResourceStep {},
        FindViewStep {},
        FindChromeStep { chrome = `/chrome` },
        ServiceViewStep {},
        LogStep { file = scriptDir + `logs/web.log` },
      ].toImmutable
    },

    //HavenService.make("haven")
    //{
    //  connection = Sys.env["sql.test.connection"]
    //  username   = Sys.env["sql.test.username"]
    //  password   = Sys.env["sql.test.password"]
    //  dialect    = Type.find(Sys.env["sql.test.dialect"]).make
    //}
  ]

  override Void setup()
  {
    sysLogger := FileLogger { file = scriptDir + `logs/sys.log` }
    sysLogger.start
    Log.addHandler(&sysLogger.writeLogRecord)

    Sys.ns.create(`/homePage`,     scriptDir + `index.html`)
    Sys.ns.create(`/chrome`,       scriptDir + `chrome.fan`)

    Sys.mount(`/dir`,   Namespace.makeDir(scriptDir + `dir/`))
    Sys.mount(`/doc`,   Namespace.makeDir(Sys.homeDir + `doc/`))
    //Sys.mount(`/haven`, Thread.find("haven")->ns)
  }
}