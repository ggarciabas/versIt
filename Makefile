# https://www.netbsd.org/docs/pkgsrc/makefile.html

FINAL_FILE := "versit.sh"
PRJ_SRC := "${PWD}/src/main.sh"
PRJ_LIB := $(shell ls -d ${PWD}/lib/*)

all: initiate add_dependencies define_main invoke_main

initiate:
	echo "#!/bin/bash" > ${FINAL_FILE};

add_dependencies:
	for filename in ${PRJ_LIB} ""; \
	do \
		cat ${filename} >> ${FINAL_FILE} \
		echo >> ${FINAL_FILE} \
	done

define_main:
	echo "function main() {" >> ${FINAL_FILE}
	cat ${PRJ_SRC} >> ${FINAL_FILE}
	echo "}" >> ${FINAL_FILE}

invoke_main:
	echo >> ${FINAL_FILE}
	echo "main \$$@" >> ${FINAL_FILE}