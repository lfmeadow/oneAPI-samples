#!/bin/bash

#PBS -l nodes=1:gpu:ppn=2
#PBS -d .

#source /opt/intel/oneapi/setvars.sh
make -f Makefile.devcloud

echo "Running on gpu"
ONEAPI_DEVICE_SELECTOR=level_zero:gpu ./vector-addition-tiled
echo "Running on cpu"
ONEAPI_DEVICE_SELECTOR=level_zero:cpu ./vector-addition-tiled

echo "expected result: 128000"
