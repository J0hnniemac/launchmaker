#!/bin/bash

#
# Copyright (C) 2016 JohnnieMac <john@appyappster.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e
	
VERSION=1.0.0

info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

usage() {
cat << EOF
VERSION: $VERSION
USAGE:
    $0 Portrait.png Landscape.png

DESCRIPTION:
    This script is for generating IOS Launch Images in differernt sizes for Portrait and Landscape
    You should have different Portrait and Landscape Sources preferably at high resolution

    Based on a script created by Wenva <lvyexuwenfa100@126.com>
    https://github.com/smallmuou/ios-icon-generator
 
    This script depends on ImageMagick. So you must install ImageMagick first
 
AUTHOR:
    JohnnieMac<john@appyappster.com>

LICENSE:
    This script follow MIT license.

EXAMPLE:
    $0 Portrait.png Landscape.png 
EOF
}

# Check ImageMagick
command -v convert >/dev/null 2>&1 || { error >&2 "The ImageMagick is not installed. You need to install it first."; exit -1; }

# Check param
if [ $# != 2 ];then
    usage
    exit -1
fi


P_FILE="$1"
L_FILE="$2"

pfilename=$(echo $P_FILE | cut -f 1 -d '.')
lfilename=$(echo $L_FILE | cut -f 1 -d '.')


PSIZE[0]="1080x1920"
PSIZE[1]="750x1334"
PSIZE[2]="640x1136"
PSIZE[3]="2048x2732"
PSIZE[4]="1563x2048"

LSIZE[0]="1920x1080"
LSIZE[1]="1334x750"
LSIZE[2]="1136x640"
LSIZE[3]="2732x2048"
LSIZE[4]="2048x1536"


PNAMEPOSTFIX[0]="7P6P-1080x1920"
PNAMEPOSTFIX[1]="67-750x1334"
PNAMEPOSTFIX[2]="SE-640x1136"
PNAMEPOSTFIX[3]="BPro-2048x2732"
PNAMEPOSTFIX[4]="Pad-1563x2048"

LNAMEPOSTFIX[0]="7P6P-920x1080"
LNAMEPOSTFIX[1]="67-1334x750"
LNAMEPOSTFIX[2]="SE-1136x640"
LNAMEPOSTFIX[3]="BPro-2732x1563"
LNAMEPOSTFIX[4]="Pad-2048x1536"

info "Portrait....."
for i in {0..4}
do
	infox="Working on $pfilename-${PNAMEPOSTFIX[$i]}.png"
	info "$infox"
   cmdStr="convert $P_FILE -resize ${PSIZE[$i]}! $pfilename-${PNAMEPOSTFIX[$i]}.png"
   #echo $cmdStr
   eval $cmdStr
done

info "Landscape....."

for i in {0..4}
do
    infox="Working on $lfilename-${LNAMEPOSTFIX[$i]}.png"
    info "$infox"
   cmdStr="convert $L_FILE -resize ${LSIZE[$i]}! $lfilename-${LNAMEPOSTFIX[$i]}.png"
   #echo $cmdStr
   eval $cmdStr
done
info 'Hopefully thats it Done.'

