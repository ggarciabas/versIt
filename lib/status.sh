#!/bin/bash

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
                    echo "${VERSIT_RED_C} (modified)   ${SUB_PATH}${VERSIT_RESET_C}"
                fi
            else
                echo  "${VERSIT_GREEN_C} (new)    ${SUB_PATH}${VERSIT_RESET_C}" # no exist, then, it is different
            fi
        fi
    done
}

status_validate () {
    DIR=$1
    # validate if .versit exist
    if [ ! -d ${DIR}/.versit ];
    then
        echo "${VERSIT_RED_C}It is necessary to initialize the project folder to versioning. Use ${VERSIT_GREEN_C}init${VERSIT_RED_C} function first.${VERSIT_RESET_C}"
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