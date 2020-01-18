FINAL_FILE := "versit.sh"
PRJ_SRC := "${PWD}/src/main.sh"
PRJ_LIB := $(shell ls -d ${PWD}/lib/*)

all: initiate add_dependencies define_main invoke_main

initiate:
	echo "#!/bin/bash" > ${FINAL_FILE};

add_dependencies:
	$(foreach file, ${PRJ_LIB},$(cat ${file} >> ${FINAL_FILE}))

define_main:
	echo "function main() {" >> ${FINAL_FILE}
	cat ${PRJ_SRC} >> ${FINAL_FILE}
	echo "}" >> ${FINAL_FILE}

invoke_main:
	echo >> ${FINAL_FILE}
	echo "main \$$@" >> ${FINAL_FILE}