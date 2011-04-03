#!/bin/sh

let hasbrew=0
let hasgit= 0
hasbrew=$(which brew)
hasgit= $(which git)
if [ $hasbrew = "" ]
then
	sudo chown -R $USER /usr/local
	curl -Lsf http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C/usr/local
else
	brew update	
fi
if [ $hasgit = "" ]
	brew install git
	brew update
fi