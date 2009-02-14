using build

class Build : BuildPod
{
  override Void setup()
  {
    podName     = "hello"
    version     = Version("1.0")
    description = "hello world example"
    depends     = ["sys 1.0"]
    srcDirs     = [`fan/`]
  }
}
