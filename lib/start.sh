#!/bin/bash

start_usage () {
    echo "usage: versit start <path>"
}

start_help () {
    start_usage
    echo ""
    echo "  <path>      Folder to activate the versioning structure (the path may exist) [if not informed the './' is considered]"
}

start_create () {
    DIR=$1
    if [ -d "${DIR}/.versit" ];
    then
        echo "There is a version structure in the path [${DIR}]."
        read -p "Do you want to erase it? y/[n]: " erase
        ERASE=${erase:-n}
        case $ERASE in
            "y") 
                rm -rf "${DIR}/.versit"
                ;;
            "n")
                exit 0
                ;;
        esac
    fi
    mkdir "${DIR}/.versit"
}

function start {
    if [ $# -eq 1 ];
    then
        start_create './'
    else
        case $2 in
            "help") 
                start_help
                ;;
            "--help") 
                start_help
                ;;
            "-h") 
                start_help	
                ;;
            *)
                DIR=$2
                if [ -d "${DIR}" ];
                then
                    start_create ${DIR}
                else
                    echo "Invalid path"
                    start_help
                fi
                ;;
        esac
    fi
}