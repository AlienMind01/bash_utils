#!/bin/bash
#===============================================================================
# AUTHOR:       : Davide Cardillo (davide.cardillo@seco.com)
# TITLE         : checking.sh
# LICENSE       : GPL
# VERSION       : 0.1
#===============================================================================
#
# INFO: Small bash library for general checking functions (return true or false)
#
#===============================================================================


# Descr. :  Check if the script runs with root access
# Input  :  none
# Outupt :  none
# Return :  1 if it is root user, 0 otherwise
# Usage  :  check_isRoot
function check_isRoot () {
	local isRoot=0
	local user=$(whoami)
	if [[ "$user" == "root" ]]; then
		isRoot=1
	else
		isRoot=0
		fi
	return $isRoot
}


# Descr. :  Check the existence of a file
# Input  :  name of the file to check
#           ( ex:  "image.img" )
# Outupt :  none
# Return :  1 if file exists, 0 otherwise
# Usage  :  check_file_exist image.img
function check_file_exist () {
	local f=${1}
	if [[ -z $f ]]; then
		echo_w "${FUNCNAME[0]} - Invalid File name. Unable to check existence"
		return 0
	fi

	if [[ -e $f ]]; then
		echo_d $(ls -lh $f)
		return 1
	else
		echo_d "file $f does not exist"
		return 0
	fi
}


# Descr. :  Check if the working partition has enough free space
# Input  :  minimum required free space
#           ( ex:  "2048MiB" )
# Output :  none
# Return :  1 if there is enough free space, 0 otherwise (also in error case)
# Usage  :  check_free_space 2048MiB
function check_free_space () {
	local min_space="${1%M*}"
	local available_space=0

	if [[ $min_space -lt 1 ]]; then
		echo_e "Invalid free space requirement..."
		return 0
	fi

	available_space=$(df . -B MiB | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $4 }')
	available_space="${available_space%M*}"
	echo_d "Available free space: ${available_space} MiB"

	if [[ ${available_space} -le ${min_space} ]]; then
		echo_e "There is no available free space (available:${available_space}MiB / required:${min_space}MiB"
		return 0
	fi

	echo_d "OK, there is enaugh available free space (${available_space}MiB)"
	return 1
}



# Descr. :  Check the connection with server
# Input  :  host name of the server
#           ( ex:  "localhost" if the server is this PC)
#           Optional inputs are the user and password account for authentication
# Output :  none
# Return :  number of the check result (zero if success)
# Usage  :  check_connection_server localhost
function check_connection_server () {
	local hostname=$1
	local user_name=$2
	local user_passwd=$3
	local check=0
	if [[ -z $hostname ]]; then
		echo_e "Invalid hostname (${hostname})"
		return 1
	fi

	if [[ ! -z $user_name ]] && [[ ! -z $user_passwd ]]; then
		wget --no-check-certificate --spider --timeout=5 --tries=3 --user ${user_name} --password ${user_passwd} ${hostname} >/dev/null 2>/dev/null
	else
		wget --no-check-certificate --spider --timeout=5 --tries=3 ${hostname} >/dev/null 2>/dev/null
	fi
	check=$?

	case ${check} in
		0)
			echo_d "No problems occurred."
			;;
		1)
			echo_e "Generic error code."
			;;
		2)
			echo_e "Parse error---for instance, when parsing command-line options, the .wgetrc or .netrc..."
			;;
		3)
			echo_e "File I/O error."
			;;
		4)
			echo_e "Network failure."
			;;
		5)
			echo_e "SSL verification failure."
			;;
		6)
			echo_e "Username/password authentication failure."
			;;
		7)
			echo_e "Protocol errors."
			;;
		8)
			echo_e "Server issued an error response."
			;;
		*)
			echo_e "Unknow error"
			;;
	esac

	return $check
}
