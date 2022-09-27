#!/bin/bash

def_vol=20

cd /opt/music/$1

while true; do
    for file in *; do
        clear;
        echo "playing: ${file}";
        if [ -f "../conf/$file.conf" ]; then 
            ffplay -nodisp -autoexit -loglevel quiet -volume $(cat ../conf/$file.conf) $file;
        else
            ffplay -nodisp -autoexit -loglevel quiet -volume $def_vol $file;
        fi
    done;
done
