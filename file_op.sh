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
		sh1=$(sh1sum ${1} | awk '{print $1}')
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





###################################################################
#                                                                 #
#                    Remote operationis Functions                 #
#                                                                 #
###################################################################
# Descr. :  Perform download of a file from remote URL
# Input  :  remote URL and destination place
#           ( ex:  "http://localhost:/file.txt /home/" )
#           Optional inputs are the user and password account for authentication
# Outupt :  none
# Return :  0 in case of download successfully complited, other in error case"
# Usage  :  download_file http://localhost:/file.txt /home/
function download_file () {
	local url=$1
	local local_dst=$2
	local user_name=$3
	local user_passwd=$4
	local check=0

	if [[ -z $url ]]; then
		echo_e "Invalid URL (${url})"
		return 1
	fi

	if [[ -e $local_dst ]]; then
		echo_e "Destination file already exists (${local_dst})"
		return 1
	fi

	check_connection $url $user_name $user_passwd
	check=$?
	if [[ $check -ne 0 ]]; then
		echo_e "Downlaod failed (${url}): connection error (${check})"
		return 1
	fi

	if [[ ! -z $user_name ]] && [[ ! -z $user_passwd ]]; then
		echo wget --no-check-certificate --timeout=5 --user ${user_name} --password ${user_passwd} ${url} -O ${local_dst}
		wget --no-check-certificate --timeout=5 --user ${user_name} --password ${user_passwd} ${url} -O ${local_dst} >/dev/null 2>/dev/null
	else
		echo wget --no-check-certificate --timeout=5 ${url} -O ${local_dst}
		wget --no-check-certificate --timeout=5 ${url} -O ${local_dst} >/dev/null 2>/dev/null
	fi
	check=$?
	case ${check} in
		0)
			echo_d "Download complited"
			;;
		*)
			echo_e "Download failed (${url}): error ${check}"
			;;
	esac

	return $check
}