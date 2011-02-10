#!/bin/bash
a=`grep "failed" $1`
if [[  -n $a ]];then
echo "Failed";
else
echo "Success";
fi;