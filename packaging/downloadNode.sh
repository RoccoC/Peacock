#!/bin/bash

# This script downloads the Node.js binary for Windows from the specified version in .nvmrc
# and places it in the nodedist directory.

NODE_VERSION=$(cat .nvmrc)
if [ -z "$NODE_VERSION" ]; then
    echo "Error: .nvmrc file is empty or not found."
    exit 1
fi

mkdir -p temp/nodedist

# check if the binary already exists
if [ -f "temp/nodedist/node.exe" ]; then
    echo "Node.js binary already exists in temp/nodedist. Skipping download."
    exit 0
fi

# check if the binary is already downloaded
if [ -f "temp/node-$NODE_VERSION-win-x64/node.exe" ]; then
    echo "Node.js binary already downloaded."
else
    echo "Downloading Node.js version $NODE_VERSION..."
    curl https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-win-x64.zip -o temp/node.zip
    unzip temp/node.zip -d temp
fi

cp temp/node-$NODE_VERSION-win-x64/node.exe temp/nodedist/node.exe
cp temp/node-$NODE_VERSION-win-x64/LICENSE temp/nodedist/LICENSE
