#! /bin/bash


source ../messages.sh

echo
echo ---- with DEGUG and VERBOSE disabled ----
echo

echo_d "debug"
echo_e "error"
echo_w "warning"
echo_i "info"
echo_i_n "info..."
echo "current line"
echo_ok "echo ok"
echo_ko "echo ko"
process_ok "process ok"
process_ko "process ko"


echo
echo ---- with DEGUG enaabled and VERBOSE disabled ----
echo

DEGUG=1

echo_d "debug"
echo_e "error"
echo_w "warning"
echo_i "info"
echo_i_n "info..."
echo "current line"
echo_ok "echo ok"
echo_ko "echo ko"
process_ok "process ok"
process_ko "process ko"


echo
echo ---- with DEGUG and VERBOSE enabled ----
echo

DEGUG=1
VERBOSE=1

echo_d "debug"
echo_e "error"
echo_w "warning"
echo_i "info"
echo_i_n "info..."
echo "current line"
echo_ok "echo ok"
echo_ko "echo ko"
process_ok "process ok"
process_ko "process ko"

echo

