#!/bin/bash
#===============================================================================
# AUTHOR:       : Davide Cardillo (davide.cardillo@seco.com)
# TITLE         : log.sh
# LICENSE       : GPL
# VERSION       : 0.1
#===============================================================================
#
# INFO: Small bash library for log management
#
#===============================================================================


# Descr. :  create a new log file with timestamp (as UUID)
# Input  :  store folder and base file name of log file
#           ( ex.: "logs/ log_file" )
# Outupt :  new log file and echo of its full name (empty string in error case)
# Return :  0 success, 1 invalid folder, 2 invalid base name, 3 unable to create file
# Usage  :  flog=$(create_new_log logs/ log_file)
function create_new_log () {
	local folder=$1
	local base=$2
	local name=

	if [[ ! -d $folder ]]; then
		echo ""
		return 1
	fi

	if [[ -z $base ]]; then
		echo ""
		return 2
	fi

	name=${base}_`date  +"%Y%m%d_%H%M"`.log

	touch ${folder}/${name}

	if [[ ! -e ${folder}/${name} ]]; then
		echo ""
		return 3
	fi

	echo "#########################################################" > ${folder}/${name}
	echo "#########################################################" >> ${folder}/${name}
	echo "                       LOG FILE" >> ${folder}/${name}
	echo "File Name: ${name}" >> ${folder}/${name}
	echo "Creation Date: `date  +"%m/%d/%Y %H:%M"`" >> ${folder}/${name}
	echo "#########################################################" >> ${folder}/${name}
	echo "#########################################################" >> ${folder}/${name}

	echo ${name}
}


# Descr. :  Add new header to the log file
# Input  :  name of the log file and the title of the header
#           ( ex.: "log_file.log 'new header'")
# Outupt :  none
# Return :  none
# Usage  :  log_add_header log_file.log 'new header'
function log_add_header () {
	if [[  -e $1 ]]; then
		echo "" >> $1
		echo "" >> $1
		echo "#########################################################" >> $1
		echo "             ${2^^}" >> $1
		echo "#########################################################" >> $1
		echo "" >> $1
	fi
}
