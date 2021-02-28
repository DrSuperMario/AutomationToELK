#!/bin/bash

########################################################
#
#
#
#               BASH Automation Sript
#           
#               Date: 28/02/2021
#
#               Automation helper with bash
#               Script finally runs python auto
#               cheks if libs are installed
#
#
#
#########################################################

echo "ELK Stack automation and installment tool"
echo "Running this scripts need sudo premissions!!!"

runnsudo = $(sudo -v)
echo ""
echo $runnsudo

echo "Running system updates"
echo " "
echo " "
sudo apt-get update -y

user=$(whoami)

echo "Checking if rpm is installed...."
echo " "
echo " "
function package_exists() {
    dpkg -l "$1" &> /dev/null   
    return $?
}


if package_exists rpm ; then

        echo "Package RPM installed .... GOOD"

else
        echo "Package RPM doesent exist. install [Y/n]: "
        read yesno

        if [[ $yesno = 'n' ]]; then
            exit
        else
            sudo apt install rpm
        fi

fi

if package_exists ansible ; then

        echo "Package ANSIBLE installed .... GOOD"

else
        echo "Package ansible doesent exist. install [Y/n]: "
        
        read yesno

        if [[ $yesno = 'n' ]]; then
            exit

        else
             sudo apt install ansible
        fi

fi

if package_exists python3 ; then
        echo "Package PYTHON3 installed .... GOOD"
else
        echo "Package PYTHON doesent exist. install [Y/n]: "

        read yesno

        if [[ $yesno = 'N' ]]; then
            exit
        else
            sudo apt install python3
        fi

fi

python3 auto.py --user $user --yaml elk.yml --inventory Inventory