#!/usr/bin/env bash

if [[ $2 = "hin-pan" ]]; then
echo "==Hindi->Punjabi===========================";
bash inconsistency.sh $1 hin-pan > /tmp/hin-pan.testvoc; bash inconsistency-summary.sh /tmp/hin-pan.testvoc hin-pan
echo ""
elif [[ $2 = "pan-hin" ]]; then
echo "==Punjabi->Hindi===========================";
bash inconsistency.sh $1 pan-hin > /tmp/pan-hin.testvoc; bash inconsistency-summary.sh /tmp/pan-hin.testvoc pan-hin
echo "";
fi
