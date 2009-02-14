
## broadcast.awk - Implementation of a broadcast server.
## Demonstrates the ability for other threads to drive input
## to pattern matching rules defined in the Jawk script
## (via the READER variable and the begin keyword).

import java.net.*;
import java.io.*;

implements Runnable

BEGIN {
  initializeCommands()
  ps[THREAD] = System.out
  (ss_t = new Thread(this, "accept thread for " (ss = new ServerSocket(8080)))).start()
}
function initializeCommands() {
  COMMANDS["quit"] = "if (sockets[THREAD] == \"\") exit ; else closeSocket(sockets[THREAD])"
  COMMANDS["dump"] = "dump ps[THREAD]"
  COMMANDS["cxn"] = "cxn()"
  COMMANDS["beep"] = "beep()"
  COMMANDS["help"] = COMMANDS["?"] = "ps[THREAD].println(\"Available commands are quit, dump, cxn, beep, help, and ?.\")"
}
function beep() {
  java.awt.Toolkit.getDefaultToolkit().beep()
  ps[THREAD].println("(console beeped)")
  if (sockets[THREAD] != "")
	print "(console beeped by " sockets[THREAD] ")"
}
function cxn(	t, c) {
  c=0
  for (t in sockets) {
	c++
	printSocketForThread(t)
  }
  ps[THREAD].println(c "" (c==1?" cxn":" cxns"))
}
function printSocketForThread(t) {
  if (t == THREAD)
	ps[THREAD].println("** " sockets[t] " **");
  else
	ps[THREAD].println("   " sockets[t] "   ");
}
function run() {
  if (THREAD == ss_t)
	runAcceptThread()
  else
	runReaderThread()
}
function runAcceptThread(	s, t) {
  while((s = ss.accept()) != null) {
	sockets[t = new Thread(this, "reader thread for " s)] = s
	t.start()
  }
}
function runReaderThread(	s) {
  s = sockets[THREAD]
  READER = new InputStreamReader(s.getInputStream())
  ps[THREAD] = new PrintStream(s.getOutputStream())
  broadcast("(CONNECTED: " s ")")
  begin
  closeSocket(s)
  delete ps[THREAD]
  delete sockets[THREAD]
  broadcast("(disconnected: " s ")")
}

/./ {
  if (COMMANDS[$0] != "")
	eval(COMMANDS[$0])
  else
	broadcast($0)
}

function broadcast(line) {
  for (thread in ps)
	ps[thread].println("--> " line)
}
function closeSocket(s) {
  try {s.close();} catch(IOException ioe) {}
}
