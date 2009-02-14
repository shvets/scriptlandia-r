SET JAVA_HOME=c:\Java\jdk1.5.0

SET REPOSITORY_HOME=c:\maven-repository

SET CLASSPATH=%REPOSITORY_HOME%\com\sun\fortress\fortress\588\fortress-588.jar
SET CLASSPATH=%CLASSPATH%;%REPOSITORY_HOME%\xtc\xtc\1.10.0\xtc-1.10.0.jar
SET CLASSPATH=%CLASSPATH%;%REPOSITORY_HOME%\concurrent\concurrent\1.3.4\concurrent-1.3.4.jar
SET CLASSPATH=%CLASSPATH%;%REPOSITORY_HOME%\bcel\bcel\5.2\bcel-5.2.jar
SET CLASSPATH=%CLASSPATH%;%REPOSITORY_HOME%\edu\rice\plt\20070717-1913\plt-20070717-1913.jar

%JAVA_HOME%\bin\java -cp %CLASSPATH% com.sun.fortress.interpreter.drivers.fs hello.fss
