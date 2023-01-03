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
    javac -d ./bin/ ./src/*.java
    java  -cp "./:./bin/" Main
fi