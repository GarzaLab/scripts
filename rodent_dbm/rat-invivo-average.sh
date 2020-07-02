#!/bin/bash

# Dependencies: ANTs & MINC tools.

# Convert Bruker files to NIFTI using BRKRAW in BIDS format.
# Terminal window should be in the project's main folder.
# This script needs the modified antsMultivariateTemplateConstruction2.sh. You can get it here: https://github.com/GarzaLab/scripts/rodent_dbm

# USAGE
# bash rat-invivo-average.sh subject session

if [ $# -eq 0 ];then

	echo "usage: "$0" subject session";

	exit 0;

else

tmpdir=$(mktemp -d)
project=$PWD

subject=$1
session=$2

## Create derivatives directory 
##
if [ ! -d ${project}/derivatives ] ; then
mkdir -p ${project}/derivatives;
fi

##########################################################################
#Prepare and average volumes
##########################################################################


# Split 4D file (2 3D volumes)

if [ ! -d ${project}/derivatives${subject}/${session}/preproc ] ; then
mkdir -p ${project}/derivatives/${subject}/${session}/preproc;
fi

ImageMath 4 ${project}/derivatives/${subject}/${session}/preproc/split.nii.gz TimeSeriesDisassemble ${project}/data/${subject}/${session}/anat/${subject}_${session}_T1w.nii.gz

# Average 
antsMultivariateTemplateConstruction2_rigidaverage.sh -d 3 -a 0 -e 0 -n 0 -m MI -t Rigid -o ${project}/derivatives/${subject}/${session}/preproc/average ${project}/derivatives/${subject}/${session}/preproc/split*.nii.gz

cp -v ${project}/derivatives/${subject}/${session}/preproc/averagetemplate0.nii.gz ${project}/derivatives/${subject}/${session}/preproc/average.nii.gz

nii2mnc ${project}/derivatives/${subject}/${session}/preproc/average.nii.gz ${project}/derivatives/${subject}/${session}/preproc/average.mnc

# QC picture
mincpik -scale 20 -t ${project}/derivatives/${subject}/${session}/preproc/average.mnc ${project}/derivatives/${subject}/${session}/preproc/${subject}_${session}_average.jpg

rm -rf $tmpdir

fi
