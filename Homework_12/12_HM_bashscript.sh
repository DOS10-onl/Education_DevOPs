#!/bin/bash

# Создание файла в директории скрипта
Path=$(pwd)
touch "$Path"/test.txt

# Using echo write the current date and time
{
echo "date"
echo 'date'
date
} >> "$Path"/test.txt
# Define 3 variables
string="This is string" #string
ping=$(ping 8.8.8.8)     #command
math=$((5*4))           #expression
# Write the output variables into file test.txt
{
echo "$string"                                     #output string
echo "$math"                                       #output math expression
ping 8.8.8.8 | tee -a                              #output command ping
} >> "$Path"/test.txt
echo "$string $math $ping"       #output values of variables in one line
