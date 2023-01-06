#!/bin/bash

#Global variables
recycle=$HOME/recyclebin
restore_info=$HOME/.restore.info

#extract original file name from restore argument
origFile=$(echo $1 | cut -d"_" -f1)

#Testing for file name
if [ $# -eq 0 ] ; then
        echo "Error: No file name given"
        exit 1
fi

checks() {
#Testing if file exists
if [ ! -e $recycle/$1 ] ; then
        echo "Error: File $1 does not exist"
        exit 2
fi
}


restoreFile() {
         mv $recycle/$1 $targetDir #moves file back to orig location
         grep -v $1 $restore_info > $HOME/.temp #Removes string containing filename from .restore.info
         mv $HOME/.temp $restore_info
                echo "File restored"
         exit 3
}

#Checks if file exists in target path
targetDir=$(grep $1 $restore_info | cut -d ":" -f2)

fileExists () {
if [ -e $targetDir ] ; then #Checks if file exists in target path
        read -p "File already exists. Do you want to overwrite? y/n:" ans
        if [[ "$ans" =~ ^[yY] ]] ; then #sees if user input matches
                restoreFile $1
        elif [[ "ans" =~ [n/N|*] ]] ; then
                echo "$1 will not be restored"
                exit 4
        fi
else
        restoreFile $1
fi
}


checks $1
fileExists $1

