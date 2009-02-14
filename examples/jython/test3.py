import java
from pawt import swing

lst = swing.JList(['a', 'b', 'c'])

swing.test(lst)

java.lang.Thread.currentThread().join()