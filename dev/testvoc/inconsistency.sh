#!/usr/bin/env bash

TMPDIR=/tmp

DICT=$1
DIR=$2

SED=sed

if [[ $DIR = "hin-pan" ]]; then

# Run the bilingual dictionary before to make sure we are only checking things we have.
lt-expand $DICT | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | $SED 's/:>:/%/g' | $SED 's/:/%/g' | cut -f2 -d'%' |  $SED 's/^/^/g' | $SED 's/$/$ ^.<sent>$/g' | apertium-pretransfer | lt-proc -b ../../hin-pan_Guru.autobil.bin | grep -v '/@' | cut -f1 -d'/' | $SED 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |\
        apertium-pretransfer|\
	lt-proc -b ../../hin-pan_Guru.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |\
        apertium-transfer -b ../../apertium-hin-pan.hin-pan.t1x  ../../hin-pan.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |\
        lt-proc -d ../../hin-pan_Guru.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | $SED 's/\^.<sent>\$//g' | $SED 's/_/   --------->  /g'

elif [[ $DIR = "pan-hin" ]]; then 

# Run the bilingual dictionary before to make sure we are only checking things we have.
lt-expand $DICT | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | $SED 's/:>:/%/g' | $SED 's/:/%/g' | cut -f2 -d'%' |  $SED 's/^/^/g' | $SED 's/$/$ ^.<sent>$/g' | apertium-pretransfer | lt-proc -b ../../pan_Guru-hin.autobil.bin | grep -v '/@' | cut -f1 -d'/' | $SED 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |\
        apertium-pretransfer|\
	lt-proc -b ../../pan_Guru-hin.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |\
        apertium-transfer -b ../../apertium-hin-pan.pan-hin.t1x  ../../pan-hin.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |\
        lt-proc -d ../../pan-hin.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | $SED 's/\^.<sent>\$//g' | $SED 's/_/   --------->  /g'

else
	echo "bash inconsistency.sh <direction>";
fi
