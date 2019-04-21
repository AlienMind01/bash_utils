#!/bin/bash
#===============================================================================
# AUTHOR:       : Davide Cardillo (davide.cardillo@seco.com)
# TITLE         : file_op.sh
# LICENSE       : GPL
# VERSION       : 0.1
#===============================================================================
#
# INFO: Small bash library for file operation functions
#
#===============================================================================


# Descr. :  Evaluate sha1 checksum of a file
# Input  :  name of the file to evaluate
#           ( ex:  "image.img" )
# Outupt :  echo of the sha1 code
# Return :  none
# Usage  :  sha1=$(get_sha1 image.img)
function get_sha1 () {
	local sh1=""
	if [[ ! -e $1 ]]; then
		sh1=""
	else
		sh1=$(sha1sum ${1} | awk '{print $1}')
	fi
	echo $sh1
}


# Descr. :  Evaluate md5 checksum of a file
# Input  :  name of the file to evaluate
#           ( ex:  "image.img" )
# Outupt :  echo of the md5 code
# Return :  none
# Usage  :  get_md5=$(get_md5 image.img)
function get_md5 () {
	local md5=""
	if [[ ! -e $1 ]]; then
		md5=""
	else
		md5=$(md5sum ${1} | awk '{print $1}')
	fi
	echo $md5
}


# Descr. :  Evaluete size of the given file
# Input  :  name of the file to evaluate
#           ( ex:  "image.img" )
# Outupt :  echo of the file size labeled with power dimension
# Return :  none
# Usage  :  size=$(get_file_size image.img)
function get_file_size () {
	local size=0
	if [[ ! -e $1 ]]; then
		size=0
	else
		size=$(wc -c < ${1})
		size=$(echo $size | awk '{ split( "B KiB MiB GiB" , v ); s=1; while( $1>1024 ){ $1/=1024; s++ } print int($1) v[s] }')
	fi
	echo $size
}