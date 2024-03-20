#!/bin/bash


output=""

for arg in $@
do
    if [ $arg == $1 ]; then
        output=$arg

        if [ ! -f "$output" ]; then
            touch $output
        fi

    else

        encodageFull=$(file -i $arg | grep -o "charset.*")
        encodage=${encodageFull#*=}

        fileTemp="fileTemp.txt";
        iconv -f $encodage -t "utf-8" $arg > $fileTemp

        if [ $arg != $2 ]; then
            var=$(cat $fileTemp | tail -n +2 | tr ";" ","); echo "$var" >> "$output"
            
        else var=$(cat $fileTemp | tr ";" ","); echo "$var" >> "$output"
            
        fi
            
        rm $fileTemp
        
    fi

done
