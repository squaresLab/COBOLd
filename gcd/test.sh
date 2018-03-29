#!/bin/bash

case $2 in
    p1) ../../src/limit 100 $1 1 10  &>/dev/null && diff <(echo "000000001") <($1 1 10)  &>/dev/null && exit 0 ;;
    p2) ../../src/limit 100 $1 20 10 &>/dev/null && diff <(echo "000000010") <($1 20 10) &>/dev/null && exit 0 ;;
    n1) ../../src/limit 100 $1 0 1   &>/dev/null && diff <(echo "000000001") <($1 0 1)   &>/dev/null && exit 0 ;;
esac
exit 1
