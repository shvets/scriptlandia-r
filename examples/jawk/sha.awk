
## Example - sha.awk
## Runs input through Java security's SHA-1 message digest.

BEGIN {
  digest = java.security.MessageDigest.getInstance("SHA-1")
  sep = System.getProperty("line.separator")
}
{
  digest.update(($0 sep).getBytes())
}
END {
  print toHexString(digest.digest())
}
function toHexString(b,	ret_val, i, v) {
  for (i=0;i<b.length;i++) {
	v = 0 Integer.toHexString(int(b[i]))
	ret_val = ret_val v.substring(int(v.length()-2))
  }
  return ret_val;
}
