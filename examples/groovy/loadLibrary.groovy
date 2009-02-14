// loadLibrary.groovy
// from: http://voituk.kiev.ua/2008/06/04/groovy-classpath-dynamic-loading

def codebase = this.getClass().getProtectionDomain().getCodeSource().getLocation()

def thisScriptFile = new File(codebase as String)

println("This script file: " + thisScriptFile)

import org.sf.scriptlandia.ScriptlandiaHelper;

ScriptlandiaHelper.resolveDependencies("commons-lang", "commons-lang", "2.3");

/*def repositoryHome = System.getProperty("repository.home")

println("Repository home: " + repositoryHome)

def libName = repositoryHome + "/commons-lang/commons-lang/2.3/commons-lang-2.3.jar"

def url = new File(libName).toURL()

println("url: " + url)
*/

//this.getClass().getClassLoader()./*getRootLoader().*/addURL(url)

Class au = Class.forName("org.apache.commons.lang.StringUtils")

assert au.isEmpty(null) && au.isEmpty("")

println(au.getName())