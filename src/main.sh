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
		source lib/start.sh
		start $*
		;;
	"status")
		source lib/status.sh
		status $*
		;;
	*) 
		help
		;;
esac