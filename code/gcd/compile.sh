#!/bin/sh

COBOL=cobc
COBOLFLAGS="-x"

if [ $# -lt 2 ] ; then
    echo "Usage: $0 __SOURCE_NAME__ __EXE_NAME__"
    exit 2
fi

src=`dirname $1`
$COBOL ${COBOLFLAGS} -o "$2" "$src"/gcd.cobol
exit $?
