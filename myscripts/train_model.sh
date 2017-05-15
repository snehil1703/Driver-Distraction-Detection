#!/bin/bash
#
# test_model.sh category iter [start_iter]

CATEGORIES=$1

RESTART=""
if [ "$3" != "" ]; then
    RESTART="-snapshot models/${CATEGORIES}/${CATEGORIES}_iter_${$3}.solverstate"
fi

aprun ./build/tools/caffe train --solver=models/${CATEGORIES}/solver.prototxt -weights models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel -gpu 0 $RESTART

