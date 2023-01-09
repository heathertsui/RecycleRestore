#  Recycle and Restore Script for Unix Command Line
The current terminal of Unix-based systems contains no ‘recycle’ command for file removal. The script contained in this repository thus serves to replicate the -rm command of Unix. However, in this instance, removed files and directories will be moved to a dedicated ‘recycle bin’ where they can be restored as required. 

# recycle.sh
Basic functionality:
* File deletion contained in command line argument; e.g bash recycle fileName.
* File name following deletion will contain original file name followed by inode number to prevent deletion of two files with same name. 
* Original absolute file path of all deleted files is saved. 
* Checks for filename, file existence, directory status and removal of recycle script. 
* Option flags: <br />
  -i : Interactive mode: prompts users for verification for file deletion. <br />
  -v : Verbose mode: displays message confirming deletion inclusive of file name. <br />
  -r : Recursive mode: for the deletion of directories and its subdirectories.<br />
  
 # restore.sh
 Basic functionality:
* Restores files within the recycle bin to their original path location through command line argument e.g. bash restore fileName_inodeNo. 
* Checks restored file against target directory in the case of duplicates in which user will be prompted for overwriting.
* Checks for filename, file existence and removal of restore script. 



