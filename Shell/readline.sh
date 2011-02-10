#!/bin/bash
cat tmp_log|while read ll;
do
        echo $ll
        if [[ $ll~/failed/ ]];then
                echo "Failed";
        else
                echo "Success";
        fi;
done;