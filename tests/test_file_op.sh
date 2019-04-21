#! /bin/bash

source ../file_op.sh
source ../messages.sh



echo_i "Size of this file ($0): $(get_file_size $0)"
echo
echo_i "MD5 checksum of this file ($0): $(get_md5 $0)"
echo
echo_i "SHA1 checksum of this file ($0): $(get_sha1 $0)"
echo