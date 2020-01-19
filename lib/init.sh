#!/bin/bash

init_usage () {
    echo "usage: versit init <path>"
}

init_help () {
    init_usage
    echo ""
    echo "  <path>      Folder to activate the versioning structure (the path may exist) [if not informed the './' is considered]"
}

init_create () {
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

function init {
    if [ $# -eq 1 ];
    then
        init_create './'
    else
        case $2 in
            "help") 
                init_help
                ;;
            "--help") 
                init_help
                ;;
            "-h") 
                init_help	
                ;;
            *)
                DIR=$2
                if [ -d "${DIR}" ];
                then
                    init_create ${DIR}
                else
                    echo "Invalid path"
                    init_help
                fi
                ;;
        esac
    fi
}