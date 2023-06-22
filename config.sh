#!/bin/bash

user_id=`id -u`

# we want to snapshot the environment of the config user
if [ $user_id -eq 0 -a -z "$RUNNER_ALLOW_RUNASROOT" ]; then
    echo "Must not run with sudo"
    exit 1
fi

# Check dotnet Core 6.0 dependencies for Linux
if [[ (`uname` == "Linux") ]]
then
    command -v ldd > /dev/null
    if [ $? -ne 0 ]
    then
        echo "Can not find 'ldd'. Please install 'ldd' and try again."
        exit 1
    fi

    message="Execute sudo ./bin/installdependencies.sh to install any missing Dotnet Core 6.0 dependencies."

    ldd ./bin/libcoreclr.so | grep 'not found'
    if [ $? -eq 0 ]; then
        echo "Dependencies is missing for Dotnet Core 6.0"
        echo $message
        exit 1
    fi

    ldd ./bin/libSystem.Security.Cryptography.Native.OpenSsl.so | grep 'not found'
    if [ $? -eq 0 ]; then
        echo "Dependencies is missing for Dotnet Core 6.0"
        echo $message
        exit 1
    fi

    ldd ./bin/libSystem.IO.Compression.Native.so | grep 'not found'
    if [ $? -eq 0 ]; then
        echo "Dependencies is missing for Dotnet Core 6.0"
        echo $message
        exit 1
    fi
