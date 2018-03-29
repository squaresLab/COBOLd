#!/bin/sh

clearsc() {
    HOME=$(tput cup 0 0)
    ED=$(tput ed)
    EL=$(tput el)
    ROWS=$(tput lines)
    COLS=$(tput cols)
    printf '%s%s' "$HOME" "$ED"
    CMD="$@"
    ${SHELL:=sh} -c "$CMD" | head -n $ROWS | while IFS= read LINE; do
        printf '%-*.*s%s\n' $COLS $COLS "$LINE" "$EL"
    done
    printf '%s%s' "$ED" "$HOME"
}

COBOL=cobc
COBOLFLAGS="-x"

if [ $# -lt 2 ] ; then
    echo "Usage: $0 __SOURCE_NAME__ __EXE_NAME__"
    exit 2
fi

src=`dirname $1`
clearsc echo ""
echo "$src:"
echo "----------------------------------------"
colordiff gcd.cobol "$src"/gcd.cobol -U100 | tail -n+4
echo "----------------------------------------"
$COBOL ${COBOLFLAGS} -o "$2" "$src"/gcd.cobol &>/dev/null
exit $?
