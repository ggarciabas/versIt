#!/bin/bash

status_usage () {
    echo "usage: versit status <path>"
}

status_help () {
    status_usage
    echo ""
    echo "  <path>      Folder to list changed files [if not informed the './' is considered]"
}

status_compare () {
    VRST_PATH=$1
    PATH=$2
    if [ -d $VRST_PATH/$PATH ];
    then
        # check diff
        diff $VRST_PATH/$PATH # necessario obter main, reavaliar estrutura! 
    fi
    echo ${PATH} # no exist, then, it is different
}

status_search () {
    echo "DIR: ${1}"
    for PATHNAME in $(ls ${1});
    do
        if [ -d ${PATHNAME} ];
        then
            echo "  Folder: ${PATHNAME}"
            status_search ${1}/${PATHNAME}
        else
            FILE=${PATHNAME}
            echo "  File: ${FILE}"


            IFS='/' read -a SEP_PATH <<< ${1} # split by '/'
            SEP_PATH=(${SEP_PATH[@]}) # transform to array
            VRST_PATH=${SEP_PATH[0]}/.versit

            for FOLDER in ${SEP_PATH[@]:1}; # do not consider the first element of an array
            do
                status_compare ${VRST_PATH} ${FOLDER}/${FILE}
            done

            # SIZE=${#SEP_PATH[@]}
            # # usar valor de array apos 1a posicao ${arr[@]:1}
            # echo "      ${MAIN_P}"
        fi
    done
}

status_validate () {
    DIR=$1
    # validate if .versit exist
    if [ ! -d ${DIR}/.versit ];
    then
        echo "Necessary to start the project folder versioning!"
        exit 1
    fi
}

function status {
    if [ $# -eq 1 ];
    then
        status_validate '.'
        status_search '.'
    else
        case $2 in
            "help")
                status_help
                ;;
            "--help")
                status_help
                ;;
            "-h")
                status_help	
                ;;
            *)
                DIR=$2
                if [ -d "${DIR}" ];
                then
                    status_validate ${DIR}
                    status_search ${DIR}
                else
                    echo "Invalid path"
                    status_help
                fi
                ;;
        esac
    fi
}