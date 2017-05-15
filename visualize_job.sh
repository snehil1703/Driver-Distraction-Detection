#!/bin/bash

#PBS -l walltime=20:00:0
#PBS -l nodes=2:ppn=16
#PBS -X
#PBS -q gpu

cd /N/dc2/scratch/snehvish/caffe

module switch PrgEnv-cray/5.2.82 PrgEnv-gnu/5.2.82
module add cudatoolkit/7.5.18-1.0502.10743.2.1
module add opencv/gnu/2.4.8
module add boost/1.54.0
module add cray-hdf5/1.8.16
module add intel/15.0.3.187
module add python/2.7.8
module add caffe

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/N/soft/cle5/caffe/20170112/caffe-master/.build_release/lib
export PYTHONPATH=${PYTHONPATH}:/N/dc2/scratch/snehvish/caffe/python

aprun python python/visualize.py
