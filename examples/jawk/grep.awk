
## Example - grep.awk
## Works a lot like the Unix grep(1) command.
## One difference is that multiple arguments do not collapse 
## into a single argument.  For example, jawk grep.awk -i -l
## treats the args appropriately, while jawk grep.awk -il
## does not.

import java.io.*;

function usage(	err) {
  err = System.err;
  err.println("usage: jawk grep.awk [-X] [-i] [-l] [-c] [-v] ([-f pattern_file] or pattern) file ..");
  exit(0)
}

BEGIN {
  if (ARGC == 0)
	usage()
  FS = ""
  OFS = ":"
  pattern_idx = 0
  for (i=0;i<ARGC;i++) {
	arg = ARGV[i]
	if (false) ;
	else if (! no_more_args && arg == "-f")
	{
		pattern_filename = ARGV[++i]
		br = new BufferedReader(new FileReader(pattern_filename))
		while((line = br.readLine()) != null)
			patterns[pattern_idx++] = line
		pattern_is_set = 1
	}
	else if (! no_more_args && arg == "-i") ignore_case = 1
	else if (! no_more_args && arg == "-l") list_files_only = 1
	else if (! no_more_args && arg == "-v") exclusion = 1
	else if (! no_more_args && arg == "-n") line_numbers = 1
	else if (! no_more_args && arg == "-c") count_only = 1
	else if (! no_more_args && arg == "-X") timing = 1
	else if (! no_more_args && arg == "-") no_more_args = 1
	else if (! no_more_args && arg ~ "^-") throwBadArgException(arg)
	else if (! pattern_is_set)
	{
		patterns[pattern_idx++] = arg
		no_more_args = pattern_is_set = 1
	}
	else
	{
		if (i<ARGC-1) {
			multi_file = 1
			if (count_only)
				for (jj=i;jj<ARGC;jj++) {
					if (ARGV[jj] == "-")
						counts["{stdin}"] = 0
					else
						counts[ARGV[jj]] = 0
				}
		}
		if (ignore_case)
			for (j=0;j<pattern_idx;j++)
				patterns[j] = "(?i)" patterns[j]
		#return
		if (timing) start_time = System.currentTimeMillis()
		next
	}
	ARGV[i] = null
  }
}
END {
  if (count_only)
	for (file in counts)
		if (counts[file] != "")
			print((multi_file?file ":":"") counts[file])
  if (timing) {
	f = System.currentTimeMillis() - start_time
	System.err.println(f/1000.0 " second(s)")
  }
}
function throwBadArgException(arg) {
  throw new IllegalArgumentException("Invalid argument: " arg)
}
{
  filename = FILENAME?FILENAME:"{stdin}"
  for (k=0;k<pattern_idx;k++) {
	pattern = patterns[k]
	if ((! exclusion && $0 ~ pattern) || (exclusion && $0 !~ pattern)) {
		if (count_only)
			counts[filename]++
		else if (list_files_only) {
			if (! file_list[filename]) {
				file_list[filename] = 1
				print filename
			}
		} else {
			if (multi_file && filename)
				print filename, (line_numbers?NR":":"") $0
			else
				print((line_numbers?NR":":"") $0)
		}
	}
  }
}
