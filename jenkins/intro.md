# Intro

## Install Jenkins

[follow here](https://www.jenkins.io/doc/book/installing/)

## New Item

Six options
- Freestyle project.
- Pipeline
- Multi-configuration project
- Folder
- Multibranch Pipeline
- Organization Folder

## Pipeline Example:

SHEDULE `* * * * *`

HelloWorld.java
```
public class HelloWorld {
    public static void main(String[] args) {
        // Prints "Hello, World" in the terminal window.
        System.out.println("Hello, World");
    }
}
```

Build Steps
- Execute Shell:
```shell
cd /home/alex/test
sudo javac ./HelloWorld.java
java HelloWorld
```

OUTPUT

```shell
Started by user Alexander Lindholm
Running as SYSTEM
Building in workspace /var/lib/jenkins/workspace/Alexander
[Alexander] $ /bin/sh -xe /tmp/jenkins17016520789577123117.sh
+ cd /home/alex/test
+ sudo javac ./HelloWorld.java
+ java HelloWorld
Hello, World
Finished: SUCCESS
```
