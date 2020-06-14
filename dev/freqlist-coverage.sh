#!/bin/bash

set -e -u

if [[ $# -eq 0 || -t 0 ]]; then
    echo "Expecting apertium arguments and a 'sort|uniq -c|sort -nr' style frequency list on stdin"
    echo "For example:"
    echo "\$ < spa.freqlist $0 -d . spa-morph"
    exit 2
fi

sed 's%^ *%<apertium-notrans>%;s% %</apertium-notrans>%;s%$% .%' |
apertium -f html-noent "$@" |
awk -F'</?apertium-notrans>| *\\^\\./\\.<sent><clb>\\$' '
/[/][*@]/ {
    unknown+=$2
    if(!printed) print "Top unknown tokens:"
    if(++printed<10) print $2,$3
    next
}
{
    known+=$2
}
END {
    total=known+unknown
    known_pct=100*known/total
    unk_pct=100*unknown/total
    print known_pct" % known of total "total" tokens"
}'