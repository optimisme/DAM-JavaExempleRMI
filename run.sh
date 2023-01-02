#!/bin/bash

# Comprimir amb: folder=`basename "$PWD"` && zip -r ../$folder.zip . -x '**/.*' -x '**/__MACOSX' -x '*.zip'

reset
rm -f ./bin/*.* 
mkdir -p ./bin
cp -r ./assets ./bin

if [[ $OSTYPE == 'linux-gnu' ]]; then
    javac -d ./bin/ ./src/*.java
    java  -cp "./:./bin/" Main
fi

if [[ $OSTYPE == 'darwin'* ]] && [[ $(arch) == 'i386' ]]; then
    javac -d ./bin/ ./src/*.java
    java  -cp "./:./bin/" Main
fi

if [[ $OSTYPE == 'darwin'* ]] && [[ $(arch) == 'arm64' ]]; then
    javac -cp "./:./bin:./lib/Java-WebSocket-1.5.3.jar:./lib/slf4j-api-2.0.3.jar:./lib/slf4j-simple-2.0.3.jar" -d ./bin/ ./src/*.java
    java  -cp "./:./bin:./lib/Java-WebSocket-1.5.3.jar:./lib/slf4j-api-2.0.3.jar:./lib/slf4j-simple-2.0.3.jar" Main
fi