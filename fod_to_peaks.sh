#!/bin/bash

set -e
set -x

# config inputs
lmax2=`jq -r '.lmax2' config.json`
lmax4=`jq -r '.lmax4' config.json`
lmax6=`jq -r '.lmax6' config.json`
lmax8=`jq -r '.lmax8' config.json`
lmax10=`jq -r '.lmax10' config.json`
lmax12=`jq -r '.lmax12' config.json`
lmax14=`jq -r '.lmax14' config.json`
lmax=`jq -r '.lmax' config.json`
num_peaks=`jq -r '.num_peaks' config.json`
threshold=`jq -r '.threshold' config.json`
fast=`jq -r '.fast' config.json`
ncores=8


# set advanced options
cmd=""

if [ ! ${num_peaks} -eq 3 ]; then
	cmd=$cmd"-num ${num_peaks} "
fi

if [ ! ${threshold} -eq 0 ]; then
	cmd=$cmd"-threshold ${threshold} "
fi

if [[ ${fast} == "true" ]]; then
	cmd=$cmd"-fast "
fi

# set the fod to the proper lmax image
fod=$(eval "echo \$lmax${lmax}")

# generate peaks if not already there
[ ! -f peaks.nii.gz ] && sh2peaks ${fod} ./peaks.nii.gz ${cmd} -force -nthreads ${ncores} -quiet
