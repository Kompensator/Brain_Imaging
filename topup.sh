#!/usr/bin/env bash

####################################################
# settings
FULL_FILE="F005_EPIDiffusion"
PA_FILE="F005_EPIDiffusionPA"
B0_FILE="b0$FULL_FILE"
MERGED_FILE="merged_$FULL_FILE"
EXTRA_FILE="extra_$FULL_FILE"
ACQ_PARAM="acq_param.txt"
####################################################

echo "topup of $FULL_FILE started at:"
echo $(date +%r)
`fslroi $FULL_FILE $B0_FILE 0 1`
`fslmerge -t $MERGED_FILE $B0_FILE $PA_FILE`
`fslroi $MERGED_FILE $EXTRA_FILE 0 -1 0 -1 0 66`
`topup --imain=$EXTRA_FILE --datain=$ACQ_PARAM --config=b02b0.cnf --out="topup_$FULL_FILE" --iout="b0_topup_$FULL_FILE"`
echo "topup of $FULL_FILE ended at:"
echo $(date +%r)
