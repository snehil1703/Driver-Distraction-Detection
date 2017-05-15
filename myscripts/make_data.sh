#!/bin/bash

CATEGORIES=$1

cd data/$CATEGORIES

FULLDATAFILE="${CATEGORIES}.full_caffe_dataset"
if [ -e $FULLDATAFILE ]; then
    echo "Refusing to overwrite `pwd`/${FULLDATAFILE}"
else
    echo 'Generating datasets for caffe...'
    cat -n ${CATEGORIES} | while read catline; do 
	CATNUM=`echo $catline | awk '{print $1;}'`
	cat=`echo $catline | awk '{print $2;}'`
	ls images/$cat/ | while read photo; do
		echo `readlink -n -e images/$cat/$photo` `expr $CATNUM - 1`
	done
    done | ../../myscripts/shuffle.sh > ${CATEGORIES}.full_caffe_dataset  


    FULLSIZE=`cat ${CATEGORIES}.full_caffe_dataset | wc -l `
    echo $FULLSIZE
    TRAINSIZE=`expr $FULLSIZE '*' 7 '/' 10`
    VALSIZE=`expr $FULLSIZE '*' 15 '/' 100`
    TESTSIZE=`expr $FULLSIZE - $TRAINSIZE - $VALSIZE`

    head -n $TRAINSIZE $FULLDATAFILE > ${CATEGORIES}.train
    tail -n `expr $TESTSIZE '+' $VALSIZE` $FULLDATAFILE | head -n $VALSIZE  > ${CATEGORIES}.val
    tail -n $TESTSIZE ${FULLDATAFILE} > ${CATEGORIES}.test

    cat ${CATEGORIES}.{val,test} > ${CATEGORIES}.testval

    wc -l ${CATEGORIES}.{train,val,test}
fi

cd ../..

