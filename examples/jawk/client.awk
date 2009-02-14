
## Example - client.awk
## Establishes a socket connection to a web server,
## reads text data, line by line, and prints the lines
## to "standard output".

import java.io.*;
import java.net.*;

BEGIN {
  try {
	s = new Socket("www.google.com", 80)
  } catch (IOException ioe) {
	s = new Socket("localhost", 80)
  }
  READER = new InputStreamReader(s.getInputStream())
  ps = new PrintStream(s.getOutputStream())
  ps.println("GET http://www.google.com/ HTTP/1.0")
  ps.println()
  ps.flush()
}
{ print }
