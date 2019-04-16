#!/bin/bash
#===============================================================================
# AUTHOR:       : Davide Cardillo (davide.cardillo@seco.com)
# TITLE         : conversion.sh
# LICENSE       : GPL
# VERSION       : 0.1
#===============================================================================
#
# INFO: Small bash library for digital size operation
#
#===============================================================================


# Descr. :  convert byte to MB
# Input  :  name of the file to evaluate
#           ( ex:  "image.img" )
# Outupt :  echo of the file size in MB
# Return :  none
# Usage  :  size=$(byte2MB image.img)
function byte2MB () {
	local size=0
	if [[ ! -e $1 ]]; then
		size=0
	else
		size=$(wc -c < ${1})
		let 'size = size / (1024 * 1024)'
	fi
	echo $size
}


function MB2MiB () {
	local size=0
	if [[ ! -e $1 ]]; then
		size=0
	else
		size=$1
		let 'size = (size * 1024 * 1024) / (1000 * 1000)'
	fi
	echo $size
}


# Descr. :  Compare two file size
# Input  :  the two size to compare, with power dimension (KiB, MiB, GiB)
#           ( ex:  "500KB 1MiB" )
# Outupt :  none
# Return :  1 if size1 > size2, 2 if size1 < size2 , 0 if size1 = size2
# Usage  :  compare_size 500KB 1MiB
function compere_size () {
	local power1=0
	local power2=0
	local val1=$(echo $1 | sed 's/[KiB-MiB-GiB]//g')
	local val2=$(echo $2 | sed 's/[KiB-MiB-GiB]//g')

	case `echo $1 | sed 's/[0-9]//g'` in
		KiB|K) power1=1000 ;;
		MiB|M) let 'power1 = 1024 * 1024' ;;
		GiB|G) let 'power1 = 1024 * 1024 * 1024' ;;
		 *) power1=1
	esac
	case `echo $2 | sed 's/[0-9]//g'` in
		KiB|K) power2=1000 ;;
		MiB|M) let 'power2 = 1024 * 1024' ;;
		GiB|G) let 'power2 = 1024 * 1024 * 1024' ;;
		 *) power2=1
	esac

	let 'val1 *= power1'
	let 'val2 *= power2'

	if [ $val1 -gt $val2 ]; then
		return 1
	elif [ $val1 -lt $val2 ]; then
		return 2
	else
		return 0
	fi
}