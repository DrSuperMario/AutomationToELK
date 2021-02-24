#!/bin/bash



echo "ELK Stack automation and installment tool"
echo "Running this scripts need sudo premissions!!!"

sudo -v
echo ""

user=$(whoami)

echo "Checking if rpm is installed...."

function package_exists() {
    dpkg -l "$1" &> /dev/null
    return $?
}

if package_exists rpm ; then
        echo "Package RPM installed .... GOOD"
else
        echo "Package RPM doesent exist. installing"
        sudo apt install rpm
fi

if package_exists ansible ; then
        echo "Package ANSIBLE installed .... GOOD"
else
        echo "Package ansible doesent exist. installing"
        sudo apt install ansible
fi

if package_exists python3 ; then
        echo "Package PYTHON3 installed .... GOOD"
else
        echo "Package PYTHON doesent exist. installing"
        sudo apt install python3
fi

python3 auto.py --user $user --yaml main.yml --inventory Inventory