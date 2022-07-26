#!/bin/bash

#Function print all files (Hidden too) in entered path

#Block that gather need info
echo "Please enter the path to directory"
read -r Path
echo "Printing all files and directories on $Path below"
sleep 1
#Declaration function
Find ()
{
    find "$Path" 2>/dev/null                                              #send error to /dev/null
    if ! make mytarget; then
    echo "" > /dev/null                                             
    else
    echo "Sorry, we didn't find anything. Please check the path and try again"
    fi
}
#Call the function
Find 
exit 1

