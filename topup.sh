#!/usr/bin/env bash

# !!! MOVE THIS FILE TO WHERE YOU HAVE ALL THE DTI DATA !!!
# to run the file:
# 1. check the settings section below. make sure FULL_FILE and PA_FILE match your subject
# 2. open command line
# 3. type in "bash topup.sh"
# 4. be patient xD

####################################################   settings

# change these file names to a different subject for topup to work
# only 2 DTI files + the data acquisition parameter file are needed for topup (no bval, bvec..)

FULL_FILE="F005_EPIDiffusion"   # this is the full DTI result file (usually the largest one in size)
PA_FILE="F005_EPIDiffusionPA"   # this is the file that has "PA" in the name
ACQ_PARAM="acq_param.txt"   # this must match the data acquisition file!

####################################################


B0_FILE="b0$FULL_FILE"
MERGED_FILE="merged_$FULL_FILE"
EXTRA_FILE="extra_$FULL_FILE"


echo "topup of $FULL_FILE started at:"
echo $(date +%r)
echo "this should take around 15 mins"
`fslroi $FULL_FILE $B0_FILE 0 1`
`fslmerge -t $MERGED_FILE $B0_FILE $PA_FILE`
`fslroi $MERGED_FILE $EXTRA_FILE 0 -1 0 -1 0 66`
`topup --imain=$EXTRA_FILE --datain=$ACQ_PARAM --config=b02b0.cnf --out="topup_$FULL_FILE" --iout="b0_topup_$FULL_FILE"`
echo "topup of $FULL_FILE ended at:"
echo $(date +%r)
