#!/bin/bash

declare -A matrix
num_rows=10
num_columns=10

for f in `ls $1`
do
    for ((i=1;i<=num_rows;i++)) do
        for ((j=1;j<=num_columns;j++)) do
            matrix[$i,$j]=0
        done
    done
    
    ctline=`wc -l $1/$f`
    IFS=' ' read -ra ct <<< "$ctline"
    count=${ct[0]}
    same=0
    while read line
    do
        IFS=' ' read -ra arr <<< "$line"
        if [ "${arr[1]}" -eq "${arr[2]}" ]; then
            ((same++))
        fi
	#martix[${arr[1]},${arr[2]}]+=1
    done < $1/$f
    acc=$((same * 100 / count))
    echo $1/$f" Accuracy: "$acc"%"

done
