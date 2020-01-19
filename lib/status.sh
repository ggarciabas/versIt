#!/bin/bash

RED_C=`tput setaf 1`
GREEN_C=`tput setaf 2`
RESET_C=`tput sgr0`

status_usage () {
    echo "usage: versit status <path>"
}

status_help () {
    status_usage
    echo ""
    echo "  <path>      Folder to list changed files [if not informed the './' is considered]"
}

status_search () {
    for PATHNAME in $(ls ${1});
    do
        if [ -d ${PATHNAME} ];
        then
            status_search ${1}/${PATHNAME}
        else
            FILE=${1}/${PATHNAME}
            
            IFS='/' read -a SEP_PATH <<< ${FILE} # split by '/'
            SEP_PATH=(${SEP_PATH[@]}) # transform to array
            VRST_PATH=${SEP_PATH[0]}/.versit

            SUB_PATH=$(echo $FILE | sed 's+\.\/++g')

            if [ -f $VRST_PATH/${SUB_PATH} ];
            then
                cmp -s $VRST_PATH/${SUB_PATH} ${FILE}
                if [ $? -eq 1 ];
                then
                    echo "${RED_C} (modified)   ${SUB_PATH}${RESET_C}"
                fi
            else
                echo  "${GREEN_C} (new)    ${SUB_PATH}${RESET_C}" # no exist, then, it is different
            fi
        fi
    done
}

status_validate () {
    DIR=$1
    # validate if .versit exist
    if [ ! -d ${DIR}/.versit ];
    then
        echo "Necessary to start the project folder to versioning!"
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