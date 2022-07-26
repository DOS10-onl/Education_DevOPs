#!/bin/bash

#Function read elements from params, send them to array, and print all elements from $i line;

#Block that declarate initial params and etc
i=1                             #Start position value
myArray=("$@")                  #Array from params
sleep 1
#Function declaration
Array()                         
{
    for arg in "${myArray[@]}"; do
    echo "$i line - $arg"
    (( i++ ))
    done
}
#Call the function
if [ $# -eq 0 ]; then
    echo "Sorry, we need some paramateres. Please enter them and try again"
else
    Array "$@"
fi
exit 1