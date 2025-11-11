Gradle is build tool which is used to build a java based project

we have a gradlew (wrapper for mac/linux) and gradlew.bat for windows based environment.

settings.graddle for basic gradle related properties 

graddle/wrapper has some more files related to configurations

there prereq for java based project. i.,e Java.

sudo apt install openjdk-21-jre-headless

read the instructions from readme.md carefully

we need to run the graddle wrapper (./gradlew)

if we dont have the permission to run the wrapper.

chmod +x ./gradlew

./gradle installDist

this command going to do multiple things.
- start the gradle daemon (server for java)
- Install the dependencies
- Performs the compilation
-- Build an application, developer also provides the location for this

this command will create the build directory and executable is created inide the directory

[Img - Java Build artifact](../assets/java-build-artifact.png)
 
export AD_PORT=9099
export FEATURE_FLAG_GRPC_SERVICE_ADDR=featureflagservice:50053

run the service

./build/install/opentelemetry-demo-ad/bin/Ad