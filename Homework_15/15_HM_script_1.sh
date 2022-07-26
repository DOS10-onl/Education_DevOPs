#!/bin/bash

#Function that multiply two param. If result even function gives - 0, if not gives - 1;

#Declaration function
Multy ()
{
    echo "The result of function is:"
    sleep 1
    M=$(($1*$2))
    D=$((M%2))
    if [ $D -eq 0 ]; then
    echo "0"                            #if result is even value
    else            
    echo "1"                            #if result is not even value
    fi
  
}
#Call the func with params
if [ $# -ne 2 ]; then
    echo "Please enter 2 params and try again"
  else
     Multy "$1" "$2"
fi
exit 1