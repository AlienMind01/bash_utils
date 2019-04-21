#!/bin/bash
#===============================================================================
# AUTHOR:       : Davide Cardillo (davide.cardillo@seco.com)
# TITLE         : network.sh
# LICENSE       : GPL
# VERSION       : 0.1
#===============================================================================
#
# INFO: Small bash library for network operation functions
#
#===============================================================================


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