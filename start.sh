#!/bin/bash

help () {
    echo "help start function"
}

function start {
    case $1 in
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
            help
            ;;
    esac
}