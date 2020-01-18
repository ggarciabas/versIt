#!/bin/bash

usage () {
    echo "usage: versit status <path>"
}

help () {
    usage
    echo ""
    echo "  <path>      Folder to list changed files"
}

function status {
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
                
            else
                echo "Invalid path"
                help
            fi
            ;;
    esac
}