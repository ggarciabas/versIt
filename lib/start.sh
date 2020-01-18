#!/bin/bash

usage () {
    echo "usage: versit start <path>"
}

help () {
    usage
    echo ""
    echo "  <path>      Folder to activate the versioning structure (the path may exist)"
}

function start {
    case $2 in
        "help") 
            help
            ;;
        "--help") 
            help
            ;;
        "-h") 
            help	
            ;;
        *)
            DIR=$2
            if [ -d "${DIR}" ];
            then
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
            else
                echo "Invalid path"
                help
            fi
            ;;
    esac
}