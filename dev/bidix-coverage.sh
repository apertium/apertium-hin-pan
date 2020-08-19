#!/usr/bin/env bash
cat ~/wiktextract/scraped_edited2.txt | apertium -d . pan_Guru-hin-biltrans | sed 's/\$[^\^]*\^/$\n^/g' > output.txt
num1=`cat output.txt | wc -l`
num2=`cat output.txt | grep -v -e '\/\*' -e '\/@' | wc -l`
echo $num2/$num1 | bc -l
