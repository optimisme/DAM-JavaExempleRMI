#!/bin/bash

folder=`basename "$PWD"` && zip -r ../$folder.zip . -x '**/.*' -x '**/__MACOSX' -x '*.zip'
