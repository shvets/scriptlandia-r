
## Example - gunzip.awk
## Uncompress data via the GNU zip uncompression algorithm
## Java SE provides classes to perform the uncompression.
## This scripts makes use of these classes to achieve file uncompression.

import java.util.zip.*
import java.io.*;

BEGIN {
  if (ARGC == 0 || ARGC==1 && ARGV[0] == "-c")
	from_stdin=1
  else
	from_stdin=0

  b = new byte[4096]
  to_stdout=0

  for (i=0;i<ARGC;i++) {
	if (i==0 && ARGV[i] == "-c") {
		to_stdout = 1
		continue
	}
	try {
		System.err.println("(gunzipping " ARGV[i] ")")
		gunzip(ARGV[i])
	} catch (Exception e) {
		System.err.println( "(could not gunzip " ARGV[i] ": " e ")")
	}
  }
  if (from_stdin)
	gunzip()
  System.err.println("(done)")
}

function gunzip(filename,	is, sb, os, len) {
  if (! filename)
	is = new GZIPInputStream(System.in)
  else {
	if (filename !~ /.gz$/)
		filename = filename ".gz"
	is = new GZIPInputStream(new FileInputStream(filename))
  }
  if (to_stdout || ! filename)
	os = System.out
  else {
	outfile = substr(filename, 1, length(filename)-3)
	os = new FileOutputStream(outfile)
  }
  while((len = is.read(b, 0, b.length)) >= 0)
	os.write(b, 0, len)
  is.close()
  if (to_stdout || ! filename)
	os.flush()
  else {
	os.close()
	new File(filename).delete()
  }
}
