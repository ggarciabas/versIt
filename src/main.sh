#!/bin/bash
# m217754

VERSION=0.1

usage () {
	echo "usage: versit [-v | --version] [-h | --help] <command> [<args>]"
}

help () {
	echo "versIt, version ${VERSION}"
	usage
	echo ""
	echo "These are common VersIt commands:"
	echo "	Initiate a version structure"
	echo "		start		Create an empty folder to store versions"
	echo "	Manage versions of code structure"
	echo "		status		Show files that have differences"
	echo "		commit		Identify new modifications and store version of it!"
}

version () {
	echo "versIt version ${VERSION}"
}

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
	"version") 
		version
		;;
	"--version") 
		version
		;;
	"-v") 
		version
		;;
	"-") 
		echo "unknown option: ${1}"
		usage
		;;
	"start")
		source ./start.sh
		start $*
		;;
	*) 
		help
		;;
esac

# if [ "$1" == "--help" ] | [ "$1" == "-h" ];
# then
	
# fi

# if [ "$1" == "--help" ] | [ "$1" == "-h" ];

# while getopts ":s:c:" opt;
# do
# 	echo "Opt: ${opt}"
# 	case $opt in
# 		s) 	FOLDER="$OPTARG"
# 			echo "Start: ${FOLDER}"
# 		;;
# 		c)  FOLDER="$OPTARG"
# 			echo "Commmit: ${FOLDER}"
# 		;;
# 		\?) echo "Invalid option: TODO[show options!]"
# 		;;
# 	esac
# done


#FOLDER=$1

#for file in $(ls $FOLDER);
#do
#	echo $file
#done
