#!/bin/bash
# redirect an input file to this and pipe to an executable
# listening to stdin. capture everything with asciinema or
# show on lecture hour

while read line
do
    grep -o . <<<$line | while read a
    do
        sleep 0.$((RANDOM%2))
        #2>&1 echo -n "${a:- }" | tee /dev/tty
        echo -n "${a:- }" | tee /dev/tty
    done
    sleep 0.4
    1>&2 echo -ne $"\n"
    echo
    sleep 1.$((RANDOM%7))
done
