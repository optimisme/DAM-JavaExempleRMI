@echo off

REM Remove any existing Project.jar file
if exist .\release rmdir /s /q .\release

REM Remove any existing .class files from the bin directory
if exist .\bin rmdir /s /q .\bin

REM Create the bin directory if it doesn't exist
if not exist .\bin mkdir .\bin

REM Copy the assets directory to the bin directory
xcopy /E /I .\assets .\bin\assets

REM Compile the Java source files and place the .class files in the bin directory
javac -d .\bin\ .\src\*.java

REM Create the Project.jar file with the specified manifest file and the contents of the bin directory
jar cfm .\release\Project.jar .\Manifest.txt -C .\bin\ .

REM Remove any .class files from the bin directory
if exist .\bin rmdir /s /q .\bin

REM Run the Project.jar file
cd .\release
java -jar Project.jar
cd ..
