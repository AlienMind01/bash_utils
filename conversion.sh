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
# Input  :  number of byte to convert
#           ( ex:  "10000000" )
# Outupt :  echo of size in MB
# Return :  none
# Usage  :  size=$(byte2MB 10000000)
function byte2MB () {
	local size=0
	if [[ $# -eq 1 ]]; then
		size=$1
		let 'size = size / (1000 * 1000)'
	else
		size=0
	fi
	echo $size
}


# Descr. :  convert byte to MiB
# Input  :  number of byte to convert
#           ( ex:  "1048576" )
# Outupt :  echo of size in MiB
# Return :  none
# Usage  :  size=$(byte2MiB 1048576)
function byte2MiB () {
	local size=0
	if [[ $# -eq 1 ]]; then
		size=$1
		let 'size = size / (1024 * 1024)'
	else
		size=0
	fi
	echo $size
}



# Descr. :  convert MiB to MB
# Input  :  number of MiB to convert
#           ( ex:  "1048576" )
# Outupt :  echo of size in MB
# Return :  none
# Usage  :  size=$(MiB2MB 52)
function MiB2MB () {
	local size=0
	if [[ $# -eq 1 ]]; then
		size=$1
		let 'size = (size * 1024 * 1024) / (1000 * 1000)'
	else
		size=0
	fi
	echo $size
}


# Descr. :  convert MB to MiB
# Input  :  number of MB to convert
#           ( ex:  "54" )
# Outupt :  echo of size in MiB
# Return :  none
# Usage  :  size=$(MB2MiB 52)
function MB2MiB () {
	local size=0
	if [[ $# -eq 1 ]]; then
		size=$1
		let 'size = (size * 1000 * 1000) / (1024 * 1024)'
	else
		size=0
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
	local val1=$(echo $1 | sed 's/[KiB-MiB-GiB-KB-MB-GB]//g')
	local val2=$(echo $2 | sed 's/[KiB-MiB-GiB-KB-MB-GB]//g')

	case `echo $1 | sed 's/[0-9]//g'` in
		KB) power1=1000 ;;
		MB) let 'power1 = 1000 * 1000' ;;
		GB) let 'power1 = 1000 * 1000 * 1000' ;;
		KiB|K) power1=1024 ;;
		MiB|M) let 'power1 = 1024 * 1024' ;;
		GiB|G) let 'power1 = 1024 * 1024 * 1024' ;;
		 *) power1=1
	esac
	case `echo $2 | sed 's/[0-9]//g'` in
		KB) power2=1000 ;;
		MB) let 'power2 = 1000 * 1000' ;;
		GB) let 'power2 = 1000 * 1000 * 1000' ;;
		KiB|K) power2=1024 ;;
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