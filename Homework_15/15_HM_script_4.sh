#!/bin/bash

#Function that can select the functon that we need from previous script1-3

#Block that declarate initial params and etc
echo "Please enter the number of function which you need to run"
echo "help notes:"
echo "1 - the function which multiply 2 arguments"
echo "2 - the function which print all files and directories on entered path"
echo "3 - the function which print elements from entered array"
echo "Enter number"
read -r Number
sleep 1
#Checking the entered number and run the selected script
case "$Number" in
1   ) echo "Please enter the 2 params"
        read -r Params
        ./script_1.sh "$Params" ;;                    #run script_1 with entered params
2   ) ./script_2.sh ;;                              #run script_2
3   ) echo "Please enter some elements of array"
        read -r Elements
        echo "The pattern \"Number of array - item of array\""
        ./script_3.sh "$Elements" ;;                  #run script_3 with entered params
*   ) echo "Please check the correct number and try again" 
        sleep 1
        echo ""
        exec ./script_4.sh ;;                           #recall this script if user enter wrong number
esac
exit 1