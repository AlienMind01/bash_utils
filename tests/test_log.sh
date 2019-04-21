
#! /bin/bash

source ../log.sh
source ../messages.sh


log_file_base=./file.log

log_file=$(create_new_log ./ ${log_file_base})
ret=$?
case $ret in
1) echo_e "root folder not specified!!!"; exit 1 ;;
2) echo_e "base name not specified!!!"; exit 1 ;;
3) echo_e "impossible to create log gile"; exit 1 ;;
*) echo "created new file log: ${log_file}" ;;
esac

log_add_header ${log_file} "new header"


echo_i "new message log!!!" >> ${log_file}
