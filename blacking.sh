#!/bin/bash

path=`dirname $1`
file=`basename $1`

cat $1 > $path/finalproject.test

echo "reinstating blackened files to original, running..."

while IFS=' ' read -r line || [[ -n "$line" ]]; do
    arr=($line)
    img=${arr[0]}
    #echo $img
    img_orig="${img/images_BACKUP/images}"
    #echo $img_orig
    cat $img_orig > $img
done < "$1"

cppout="blacking.out"
if [ -f $cppout ]
then
    rm $cppout
fi

g++ blacking.cpp  -o blacking.out -I/usr/X11R6/include -L/usr/X11R6/lib -lX11 -lpthread -I. 

echo "blacking.cpp running..."

while IFS=' ' read -r line || [[ -n "$line" ]]; do
    arr=($line)
    img=${arr[0]}
    #echo $img
    ./blacking.out $img $2
done < "$1"

echo "blacking complete!removing old output files if exists, running..."

test227="data/finalproject/finalproject_blacking.test-227.test.txt"
if [ -f "$test227" ]
then
    rm $test227
fi
imgs227="data/finalproject/images-227"
if [ -d "$imgs227" ] 
then
    rm -rf $imgs227
fi

echo "test_job running..."

qsub test_job.sh
