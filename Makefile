FINAL_FILE = "versit.sh"
PRJ_SRC = "${PWD}/src/main.sh"
PRJ_LIB = $(shell ls -d ${PWD}/lib/*)
SHELL := /bin/env bash

all: define_main add_dependencies invoke_main

define_main:
	echo -e "#!/usr/bin/env bash\n" > ${FINAL_FILE}
	echo -e "function main() {\n" >> ${FINAL_FILE}
	cat "${PRJ_SRC}" | sed -e 's/^/  /g' >> ${FINAL_FILE}
	echo -e "\n}\n" >> ${FINAL_FILE}

invoke_main:
	echo "main \$$@" >> ${FINAL_FILE}

add_dependencies:
	for filename in $${PRJ_LIB[*]}; 
	do 
		cat $${filename} >> ${FINAL_FILE}; 
		echo >> ${FINAL_FILE}; 
	done