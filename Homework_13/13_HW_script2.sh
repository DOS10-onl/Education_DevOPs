#!/bin/bash

#Count the amount of files
Path=$(pwd)
Number=$(find "$Path"/Myfolder -type f | wc | awk '{printf $1}') 		#Amount of all files in dir Myfolder
echo "The quantity files is: $Number"
sleep 1
#Find the files with permission 777 and replace on 664
echo "Start finding files with permission 777"
sleep 2
Name=$(find "$Path"/Myfolder -perm 777)
if ! find "$Path"/Myfolder -perm 777 2>/dev/null; then
	echo "There are no files with permission 777"
else
	echo "The file $Name has 777 permission. Start mode permission to 664"
        chmod 664 "$Name"
	sleep 1
	echo "The file $Name has changed permission to 664"
fi

#Detects empty file and remove them
sleep 1
echo "Start find empty files"
sleep 2
empty=$(find "$Path"/Myfolder -empty)
if ! find "$Path"/Myfolder -empty 2>/dev/null; then
	echo "There are no empty files"
else
	echo "The next files are empty:"
	echo "$empty"
fi
sleep 1
echo "Starting deleting empty  files"
find "$Path"/Myfolder -empty -delete 1>/dev/null 2>&1
sleep 2
echo "There are no empty files"

#Remove all lines except first in files above
sleep 1
echo "Starting removing lines except first in remaining files"
sleep 2
Number_files=$(find "$Path"/Myfolder -type f | wc | awk '{printf $1}')		#Amount of files for loop
for (( i=1; i<= "$Number_files"; i++ )) do
	a=$(find Myfolder/file* | sed -n "$i"'\p')					#The full name of file
	sed -i '1!d' "$a"								#Removing all lines except first in file
done
if sed -i '1!d' "$a"; then
echo "Removing done succesfull"
else
echo "Something going wrong"
fi
sleep 1
#Count the amount of files
Number=$(find "$Path"/Myfolder -type f | wc | awk '{printf $1}')           #Amount of all files in dir Myfolder
echo "The quantity files is: $Number"
sleep 1
ls -alh "$Path"/Myfolder							#List remaining files
