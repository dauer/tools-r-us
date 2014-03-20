#!/bin/bash

for dir in ./*; do (
    if [ -d $dir ]; then
        cd "$dir" &&
        if [ -d '.git' ]; then
            branch=`git branch` &&
            echo -e "$branch \t $dir";
        fi
    fi
) done
