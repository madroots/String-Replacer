#!/bin/bash
#
#
# CLEAR SHIT OUT
clear
VERSION=1.0.1
#
#
# Help section
Help()
{
   echo 
   echo "This is String Replacer $VERSION."
   echo
   echo "This script will guide you. Run with no options."
   echo 
   echo "Syntax: bash search_replace.sh [-h]"
   echo
   echo "options:"
   echo "h     Print this Help."
   echo
   echo
   echo "To run script successfully, check following:"
   echo
   echo "Program expects you to setup ~./ssh/config file correctly." 
   echo "It doesn't support password/ssh key directly." 
   echo "Make sure your ~/.ssh/config is working!"
   echo
   echo "Bye asshole"
}
#
#
# HEADER ASCII
cat << "EOF"
 .-._                                                   _,-,
  `._`-._                                           _,-'_,'
     `._ `-._                                   _,-' _,'
        `._  `-._        __.-----.__        _,-'  _,'
           `._   `#==="""           """===#'   _,'
              `._/)  ._               _.  (\_,'
               )*'     **.__     __.**     '*(
               #  .==..__  ""   ""  __..==,  #
-Simon-        #   `"._(_).       .(_)_."'   #
               #                             #
################    STRING REPLACER V1.0.1   #################


EOF
#
#
# Help option enabled
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
#
#
# SPECIFY REMOTE SERVER
echo -e "\e[93m [?] Specify Remote Server Location \e[0m"
read -p "Enter Remote Location: " RHOST
sleep 0.5
echo -e "\e[92m [+] Remote Location Saved Successfully \e[0m"
sleep 0.3
echo -e "Location is\e[31m $RHOST \e[0m"
echo ""
echo ""
#
#
# SPECIFY FILE TO SEARCH AND REPLACE IN
echo -e "\e[93m [?] Which File To Locate? \e[0m"
read -p "Enter What File To Locate: " RLOCATE
sleep 0.5
ssh $RHOST "sudo updatedb"
RFILE_PATH=$(ssh $RHOST "locate $RLOCATE")
echo -e "\e[92m [+] Remote File Found \e[0m"
sleep 0.3
echo -e "File is\e[31m $RFILE_PATH \e[0m"
echo ""
echo ""
#
#
# SPECIFY WHAT TO SEARCH FOR WITHIN THE FILE
echo -e "\e[93m [?] Search Value \e[0m"
read -p "Enter What To Search For Within The File : " RSEARCH
sleep 0.5
echo -e "\e[92m [+] Search String Saved Successfully \e[0m"
sleep 0.3
echo ""
echo ""
#
#
# SPECIFY WHAT TO REPLACE THE SEARCH VALUE WITH
echo -e "\e[93m [?] Replace Value \e[0m"
read -p "Enter What To Replace The Search Value With : " RREPLACE
sleep 0.5
echo -e "\e[92m [+] Search And Replace Saved Successfully \e[0m"
sleep 0.3
echo -e "I am going to find and replace\e[31m $RSEARCH with $RREPLACE \e[0m"
echo ""
echo ""
#
#
# EXECUTION
echo -e "\e[93m [!] EXECUTING COMMAND \e[0m"
echo
echo
ssh $RHOST "sed -i 's/$RSEARCH/$RREPLACE/' $RFILE_PATH"
echo
echo
ssh $RHOST "cat $RFILE_PATH | grep -B 4 -A 4 --color '$RREPLACE' $RFILE_PATH"
echo
echo -e "\e[92m Finished, have a good day \e[0m"
