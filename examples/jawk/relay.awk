
## Example - relay.awk
## For each incomming (TCP) connection, another socket connection is
## made to another server, relaying data from one socket to the other.
## By default, the script relays traffic to www.sourceforge.net:80.
## To test, execute this script and have your web browser
## surf to http://localhost:6789/
## This script demonstrates the use of threads where each thread
## handles socket traffic the traditional, Java way (i.e., via the
## use of InputStream.read() and OutputStream.write(), not via the
## use of READER and the "begin" keyword).

import java.io.*;
import java.net.*;

implements Runnable

BEGIN {
  remote_server_host = "www.sourceforge.net"
  remote_server_port = 80
  ss = new ServerSocket(6789)
  ss_t = new Thread(this, "serversocket thread for relay_server")
  ss_t.start()
}

## console command processing (via stdin)

/^[ 	]*$/{ next }
/^dump$/{ dump ; next }
/^quit$/{ exit ; next }
{ print "Unknown command: " $1 }

function run() {
  if (THREAD == ss_t)
	runAcceptThread()
  else
	runReaderThread()
}

function runAcceptThread(	s, s2, os, os2, t) {
  while((s = ss.accept()) != null) {
	try {
		print "accepted: " s
		## s = client socket
		## s2 = relay socket
		s2 = new Socket(remote_server_host, remote_server_port)
	} catch (IOException ioe) {
		ioe.printStackTrace();
		closeSocket(s);
		closeSocket(s2);
		print "aborting threads creation"
		continue
	}

	sockets[t = new Thread(this, "client socket reader thread")] = s
	other_sockets[s] = s2
	t.start()

	sockets[t = new Thread(this, "relay socket reader thread")] = s2
	other_sockets[s2] = s
	t.start()
  }
}

## inbound connection to the server
## establish a connection to the 
function runReaderThread(	socket, other_socket, is, os, b, len) {
  socket = sockets[THREAD]
  other_socket = other_sockets[socket]
  is = socket.getInputStream();
  os = other_socket.getOutputStream();
  b = new byte[4096]
  len = 0
  try {
	while((len = is.read(b, 0, b.length)) >= 0)
		os.write(b, 0, len)
  } catch (IOException ioe) {
	ioe.printStackTrace();
	print "(closing socket and terminating the thread)..."
  }
  closeSocket(socket);
  closeSocket(other_socket)

  delete sockets[THREAD]
  delete other_sockets[socket]

  print "Done with thread: " THREAD
}

function synchronized closeSocket(s) {
  try {s.shutdownInput();}catch(Exception e){}
  try {s.shutdownOutput();}catch(Exception e){}
  try {s.close();}catch(Exception e){}
}
