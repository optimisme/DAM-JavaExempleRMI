@echo off
SETLOCAL

set folderDevelopment=Project
set folderRelease=Release

:: Get into the development directory
cd %folderDevelopment%

:: Remove any existing .class files from the bin directory
if exist bin rmdir /s /q bin

:: Create the bin directory if it doesn't exist
if not exist bin mkdir bin

:: Copy the assets directory to the bin directory
xcopy /E /I assets bin\assets

:: Compile the Java source files and place the .class files in the bin directory
javac -d bin src\*.java

:: Create the Project.jar file with the specified manifest file and the contents of the bin directory
jar cfm Project.jar Manifest.txt -C bin .

:: Remove any .class files from the bin directory
if exist bin rmdir /s /q bin

:: Get out of the development directory
cd ..

:: Remove any existing folderRelease
if exist %folderRelease% rmdir /s /q %folderRelease%

:: Create the release directory if it doesn't exist
if not exist %folderRelease% mkdir %folderRelease%

:: Move the Project.jar file to the release directory
move %folderDevelopment%\Project.jar %folderRelease%\Project.jar

:: Create the run.bat file
(echo echo java -jar Project.jar) > %folderRelease%\run.bat

:: Run the Project.jar file
cd %folderRelease%
start run.bat
cd ..

ENDLOCAL