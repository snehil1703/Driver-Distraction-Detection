#!/bin/bash
#
# test_model.sh test-category iter [train-category] [testval]
#
# if specified, train-category says which model to use. If not given, assumes the same.
# if specified, testval tests on test+validation data instead of just test

CATEGORIES=$1
ITER=$2
TRAIN_CAT=$CATEGORIES

if [ "$3" != "" ]; then
    TRAIN_CAT=$3
fi

TEST_FILE=data/${CATEGORIES}/${CATEGORIES}."test"
if [ "$4" != "" ]; then
    TEST_FILE=$4
fi

cat $TEST_FILE | sed 's/.*\/data\/finalproject/data\/fp1/g;s/\/images\//\/images-227\//g;' | awk '{ print "'`pwd`'/"$0; }'> ${TEST_FILE}-227.test.txt

if [ -e data/${CATEGORIES}/images-227 ]; then
    echo 'Refusing to overwrite images-227.'

else
    echo 'Resizing test images...'
    
    mkdir data/${CATEGORIES}/images-227


    
    cat data/${TRAIN_CAT}/${TRAIN_CAT} | while read cat; do 
	mkdir data/${CATEGORIES}/images-227/$cat
    done
    
    cat $TEST_FILE | awk '{print $1;}' | while read i; do
        convert -resize '227x227!' $i `echo $i | sed 's/.*\/data\/finalproject/data\/fp1/g;s/\/images\//\/images-227\//g;'`
    done
fi

# check that image files are actually there!
cat data/${CATEGORIES}/${CATEGORIES}.test-227.test.txt | awk '{print $1;}' | while read f; do
    if [[ ! -e $f ]]; then
        printf '%s is missing in %s\n' "$f" "$2"
        exit 1
    fi
done

echo aprun python python/classify.py --model_def=models/${TRAIN_CAT}/deploy.prototxt --gpu ${TEST_FILE}-227.test.txt ${CATEGORIES}-out.txt
aprun python python/classify.py --pretrained_model=models/${TRAIN_CAT}/${TRAIN_CAT}_iter_${ITER}.caffemodel --model_def=models/${TRAIN_CAT}/deploy.prototxt --gpu ${TEST_FILE}-227.test.txt ${CATEGORIES}-out.txt
