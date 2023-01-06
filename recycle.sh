#!/bin/bash

#Global Variables
recycle=$HOME/recyclebin
restoreInfo=$HOME/.restore.info

#Adding optionflags
  opti=false
  optv=false
  optr=false
  while getopts :ivr opts
  do
      case "$opts" in
          i) opti=true;;
          v) optv=true;;
          r) optr=true;;
          ?) echo "recycle -$? invalid option. Try 'recycle --help' for more information."
          exit 2;;
      esac
  done
  shift $((OPTIND-1))

#checks if recycle doesn't exist and create one if this is true

   if [[ ! -d $recycle ]] ; then  #if there is no directory called recycle in home
                mkdir /$HOME/recyclebin #directory recycle is created
        fi
        if [[ ! -e $restoreInfo ]] ; then
                touch /$HOME/.restore.info
        fi
 


#Testing for operand
if [ $# -eq 0 ] ; then
        echo "Error: No file name given"
        exit 1
fi

#Testing if file exists
if [ ! -e $1 ] ; then
        echo "Error: File $1 does not exist"
        exit 1
#Testing if directory provided instead of file name
elif [ -d $1 ] ; then
        echo "Error: Cannot delete directory"
        exit 1
#testing if file being deleted is the recycle script
elif echo $1 | grep -q "recycle" ; then
        echo "Attempting to delete recycle - operation aborted"
        exit 1
else 

if ($opti = "true") ; then
	read -p "remove regular empty file '$1'? y/n:" ans
	case $ans in
		y|Y|yes) ;;
		n|N|*) 
                echo "file $1 will not be removed"
		exit 3;;
	esac

fi

if ($optv = "true")
	then
	echo "File '$1' has been sent to recyclebin"
fi

if ($optr = "true")
	then
	echo "$1 removed"
fi





  #Assigning fileName_inode to files being sent to recycle


        inodeNum=$(ls -i $1 | cut -d " " -f1) #get node number from file
        baseFile=$(basename $1) #extract file name from path
        absPath=$(readlink -nf $1) #original absolute path of file
        recycleName=$baseFile"_"$inodeNum #creates new file with file name and inode num

        echo $recycleName:$absPath >> $HOME/.restore.info #send recycle name and absolute directory to hidden file
        mv $1 $HOME/recyclebin/$recycleName #move file to recycle with inode number
        
fi









