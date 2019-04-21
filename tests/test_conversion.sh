#! /bin/bash

source ../conversion.sh
source ../messages.sh



echo
echo_i "1000000 byte are $(byte2MB 1000000)MB"
echo
echo_i "1048576 byte are $(byte2MiB 1048576)MiB"
echo
echo_i "52MiB are $(MiB2MB 52)MB"
echo
echo_i "54MiB are $(MB2MiB 54)MB"
echo
c1=1000KB
c2=1MB
echo_i_n "$c1 compared with ${c2}?... "
compere_size $c1 $c2
ret=$?
case $ret in
    0) echo "are equal";;
    1) echo "$c1 is greater than $c2";;
    2) echo "$c1 is less than $c2";;
    *) echo "I do no";;
esac
echo
echo
c1=1000KB
c2=1MiB
echo_i_n "$c1 compared with ${c2}?... "
compere_size $c1 $c2
ret=$?
case $ret in
    0) echo "are equal";;
    1) echo "$c1 is greater than $c2";;
    2) echo "$c1 is less than $c2";;
    *) echo "I do no";;
esac
echo
echo
c1=1024KiB
c2=1MiB
echo_i_n "$c1 compared with ${c2}?... "
compere_size $c1 $c2
ret=$?
case $ret in
    0) echo "are equal";;
    1) echo "$c1 is greater than $c2";;
    2) echo "$c1 is less than $c2";;
    *) echo "I do no";;
esac
echo