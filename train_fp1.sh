#!/bin/bash

FILE=$1

RESTART=""
if [ "$3" != "" ]; then
	RESTART="-snapshot models/${FILE}/${FILE}_iter_${3}.solverstate"
fi

aprun ./build/tools/caffe train -solver models/${FILE}/solver.prototxt -gpu 0 $RESTART
