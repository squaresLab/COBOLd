#!/bin/bash

case $2 in
    p1) OUTPUT="$(../../src/limit 100 $1 0)" && diff <(echo "000001980") <(echo "$OUTPUT") && exit 0 ;;
    p2) OUTPUT="$(../../src/limit 100 $1 1)" && diff <(echo "000001980") <(echo "$OUTPUT") && exit 0 ;;
    p3) OUTPUT="$(../../src/limit 100 $1 365)" && diff <(echo "000001980") <(echo "$OUTPUT") && exit 0 ;;
    p4) OUTPUT="$(../../src/limit 100 $1 14000)" && diff <(echo "000002018") <(echo "$OUTPUT") && exit 0 ;;
    p5) OUTPUT="$(../../src/limit 100 $1 1826)" && diff <(echo "000001984") <(echo "$OUTPUT") && exit 0 ;;
    p6) OUTPUT="$(../../src/limit 100 $1 1000)" && diff <(echo "000001982") <(echo "$OUTPUT") && exit 0 ;;
    n1) OUTPUT="$(../../src/limit 100 $1 366)" && diff <(echo "000001980") <(echo "$OUTPUT") && exit 0 ;;
    n2) OUTPUT="$(../../src/limit 100 $1 1827)" && diff <(echo "000001984") <(echo "$OUTPUT") && exit 0 ;;
esac
exit 1
