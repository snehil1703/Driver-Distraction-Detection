#!/bin/tcsh
# randomize lines in a file 
# shuffle.sh filename 

cat $1 | awk 'BEGIN { srand() } { print rand() "|" $0 }' | sort | awk 'BEGIN {FS="|";} { print $2; }'
