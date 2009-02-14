/*
<?xml version="1.0"?>
   <project name="DemoProject" basedir="." default="build">

      <property name="src_dir" value="src"/>
      <property name="lib_dir" value="lib"/>
      <property name="build_dir" value="classes"/>
      <property name="dist_dir" value="dist"/>
      <property name="file_name" value="whoami"/>

      <path id="master-classpath">
         <fileset dir="${lib_dir}">
            <include name="*.jar"/>
         </fileset>
         <pathelement path="${build_dir}"/>
      </path>

      <target name="clean">
         <delete dir="${build_dir}"/>
         <delete dir="${dist_dir}"/>
      </target>

      <target name="build" description="Compile main source tree java files">
         <mkdir dir="${build_dir}"/>
         <javac destdir="${build_dir}" debug="true" failonerror="true">
            <src path="${src_dir}"/>
            <classpath refid="master-classpath"/>
         </javac>
      </target>


      <target name="dist" depends="clean, build">
         <mkdir dir="${dist_dir}"/>
         <jar basedir="${build_dir}" destfile="${dist_dir}/${file_name}.jar" />
      </target>

   </project>

*/

class Build {
   def ant = new AntBuilder()

   def base_dir = "./"
   def src_dir = base_dir + "src"
   def lib_dir = base_dir + "lib"
   def build_dir = base_dir + "classes"
   def dist_dir = base_dir + "dist"
   def file_name = "whoami"

   def classpath;

   Build() {
     ant.mkdir(dir: "${lib_dir}")

     classpath = ant.path {
        fileset(dir: "${lib_dir}"){
           include(name: "*.jar")
        }
        pathelement(path: "${build_dir}")
     }
   }

   void clean() {
    delete(dir: "${build_dir}")
    delete(dir: "${dist_dir}")
   }

   void build() {
      ant.mkdir(dir: "${lib_dir}")
      ant.mkdir(dir: "${src_dir}")

      ant.mkdir(dir: "${build_dir}")
      ant.javac(destdir: "${build_dir}", srcdir: "${src_dir}", classpath: "${classpath}")
   }

   void jar() {
      clean()
      build()
      ant.mkdir(dir: "${dist_dir}")
      ant.jar(destfile: "${dist_dir}/${file_name}.jar", basedir: "${build_dir}")
   }

   void run(args) {
      if ( args.size() > 0 ) {
         invokeMethod(args[0], null )
      }
      else {
         build()
      }
   }

   static void main(args) {
      def b = new Build()
      b.run(args)
   }

}

