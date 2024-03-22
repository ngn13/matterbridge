#!/bin/bash

ver_line=$(sed '4q;d' version/version.go)
version=$(echo $ver_line | cut -d "=" -f2 | sed 's/"//g' | sed 's/ //g')

rm -r dist && mkdir -p dist

echo "Building for linux amd64"
CGO_ENABLED=0 go build 
mv matterbridge "dist/matterbridge_$version.linux64"

echo "Building for linux i386"
CGO_ENABLED=0 GOARCH=386 go build 
mv matterbridge "dist/matterbridge_$version.linux32"

echo "Getting hashes"
pushd dist > /dev/null
	sha256sum * > matterbridge_$version.sha256
popd > /dev/null
