#!/bin/bash

# setup_model.sh category [-r]
# optional -r flag means to set up a regression instead of a classification model

CATEGORY=$1
CATCOUNT=`cat data/$1/$1 | wc -l`
FLAG="$2"

mkdir models/$CATEGORY

if [[ "$FLAG" == "-r" ]]; then
    cat models/finetune_flickr_style/solver.prototxt | sed 's/^\s*net:.*/net: "models\/'$CATEGORY'\/train_val.prototxt"/g;s/^\s*snapshot_prefix:.*/snapshot_prefix: "models\/'$CATEGORY'\/'$CATEGORY'"/g;s/^\s*base_lr:.*/base_lr: 0.00001/g;' > models/$CATEGORY/solver.prototxt
else
    cat models/finetune_flickr_style/solver.prototxt | sed 's/^\s*net:.*/net: "models\/'$CATEGORY'\/train_val.prototxt"/g;s/^\s*snapshot_prefix:.*/snapshot_prefix: "models\/'$CATEGORY'\/'$CATEGORY'"/g;' > models/$CATEGORY/solver.prototxt
fi

for P in train_val deploy; do
    if [[ "$FLAG" == "-r" ]]; then
	cat models/finetune_flickr_style/${P}.prototxt | sed 's/flickr_style/'${CATEGORY}'/g;s/^name:.*/name: "'$CATEGORY'CaffeNet"/g;s/flickr/'${CATEGORY}'/g;s/\s*num_output: 20/num_output: 1/g;s/^\s*source:.*train.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.train"/g;s/^\s*source:.*test.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.val"/g;s/^\s*type: .SoftmaxWithLoss./type: "EuclideanLoss"/g;s/^\s*type: .Accuracy./type: "EuclideanLoss"/g;'  > models/$CATEGORY/${P}.prototxt
    else
	cat models/finetune_flickr_style/${P}.prototxt | sed 's/flickr_style/'${CATEGORY}'/g;s/^name:.*/name: "'$CATEGORY'CaffeNet"/g;s/flickr/'${CATEGORY}'/g;s/\s*num_output: 20/num_output: '${CATCOUNT}'/g;s/^\s*source:.*train.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.train"/g;s/^\s*source:.*test.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.val"/g;' > models/$CATEGORY/${P}.prototxt
    fi

done
TMP=`mktemp`
head -n -6 models/$CATEGORY/deploy.prototxt  > $TMP
mv $TMP models/$CATEGORY/deploy.prototxt


#cat models/finetune_flickr_style/deploy.prototxt | sed 's/flickr_style/'${CATEGORY}'/g;s/^name:.*/name: "'$CATEGORY'CaffeNet"/g;s/flickr/'${CATEGORY}'/g;s/\s*num_output: 20/num_output: '${CATCOUNT}'/g;s/^\s*source:.*train.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.train"/g;s/^\s*source:.*test.*/source: "data\/'$CATEGORY'\/'$CATEGORY'.val"/g;' > models/$CATEGORY/deploy.prototxt

