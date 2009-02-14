
## Example - gzip.awk
## Compress data via the GNU zip compression algorithm
## Java SE provides classes to perform the compression.
## This scripts makes use of these classes to achieve file compression.

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
		System.err.println("(gzipping " ARGV[i] ")")
		gzip(ARGV[i])
	} catch (Exception e) {
		System.err.println("(could not gzip " ARGV[i] ": " e ")")
	}
  }
  if (from_stdin) {
	System.err.println("(gzipping stdin)")
	gzip()
  }
  System.err.println("(done)")
}

function gzip(filename,	is, sb, os, len) {
  if (! filename)
	is = System.in
  else {
	if (filename ~ /.gz$/)
		throw new IllegalArgumentException("Filename already ends with .gz")
	is = new FileInputStream(filename)
  }
  if (to_stdout || ! filename)
	os = new GZIPOutputStream(System.out)
  else {
	outfile = filename ".gz"
	os = new GZIPOutputStream(new FileOutputStream(outfile))
  }
  while((len = is.read(b, 0, b.length)) >= 0)
	os.write(b, 0, len)
  is.close()
  os.finish()
  if (to_stdout || ! filename)
	os.flush()
  else {
	os.close()
	new File(filename).delete()
  }
}
