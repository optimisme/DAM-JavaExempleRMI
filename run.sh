#!/bin/bash

reset

# Remove any existing Project.jar file
rm Project.jar

# Remove any existing .class files from the bin directory
rm -f ./bin/*.* 

# Create the bin directory if it doesn't exist
mkdir -p ./bin

# Copy the assets directory to the bin directory
cp -r ./assets ./bin

# Compile the Java source files and place the .class files in the bin directory
javac -d ./bin/ ./src/*.java

# Create the Project.jar file with the specified manifest file and the contents of the bin directory
jar cfm Project.jar ./src/Manifest.txt -C bin .

# Remove any .class files from the bin directory
rm -f ./bin/*.* 
rmdir ./bin

# Run the Project.jar file
java -jar Project.jar