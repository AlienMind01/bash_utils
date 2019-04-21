
#! /bin/bash

source ../checking.sh
source ../messages.sh



# Am I the root user?
check_isRoot
ret=$?
echo
if [[ $ret -eq 1 ]]; then
    echo_i "I am the root user!!!"
else
    echo_i "I am not the root user!!!"
fi
echo



# check if I exist
file=$0
echo
echo_i_n "Does $file (I) exist? ..."
check_file_exist $file
ret=$?
if [[ $ret -eq 1 ]]; then
    echo "yes (of coures)!!!"
else
    echo "no (there is a problem)!!!"
fi
file="fileThatDoesNotExist"
echo_i_n "Does $file exist? ..."
check_file_exist $file
ret=$?
if [[ $ret -eq 1 ]]; then
    echo "yes!!!"
else
    echo "no!!!"
fi
echo



# Check enough free space
size=10MiB
echo_i_n "there is more the $size free?... "
check_free_space $size
ret=$?
if [[ $ret -eq 1 ]]; then
    echo "yes (goodness)!!"
else
    echo "no!!!"
fi
size=100000MiB
echo_i_n "there is more the $size free?... "
check_free_space $size
ret=$?
if [[ $ret -eq 1 ]]; then
    echo "yes (goodness)!!"
else
    echo "no!!!"
fi
echo


#check internet connection
echo
echo_i_n "Check connetion to google.it... "
check_connection_server google.it
ret=$?
if [[ $ret -eq 0 ]]; then
    echo "yes"
else
    echo "no"
fi
echo
echo_i_n "Check connetion to google00.it... "
check_connection_server google00.it
ret=$?
if [[ $ret -eq 0 ]]; then
    echo "yes"
else
    echo "no"
fi