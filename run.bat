rem run with: .\run.bat

cls

rem Remove any existing Project.jar file
del Project.jar

rem Remove any existing .class files from the bin directory
del /q bin\*.*

rem Create the bin directory if it doesn't exist
mkdir bin

rem Copy the assets directory to the bin directory
xcopy assets bin\assets /E /I /Y

rem Compile the Java source files and place the .class files in the bin directory
javac -d bin src\*.java

rem Create the Project.jar file with the specified manifest file and the contents of the bin directory
jar cfm release\Project.jar src\Manifest.txt -C bin .

rem Remove any .class files from the bin directory
del /q bin\*.*
rmdir bin

rem Run the Project.jar file
cd release
java -jar Project.jar
cd ..