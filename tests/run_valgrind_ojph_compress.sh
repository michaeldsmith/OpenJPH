#!/bin/bash

set -x
set -u 

PATH_TO_EXECUTABLE="../build/src/apps/ojph_compress/ojph_compress"
INPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr"
OUTPUT_FILENAME="/tmp/out.j2c"
#ADDITIONAL_COMMAND_LINE_OPTIONS=""
#ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible true"
#ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible true -colour_trans false"
#ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible false"
#ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible false -colour_trans false"
#ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible false -qstep 0.025"
ADDITIONAL_COMMAND_LINE_OPTIONS="-reversible false -colour_trans false -qstep 0.5"

valgrind -s --error-exitcode=1 --leak-check=full --track-origins=yes --show-leak-kinds=all ${PATH_TO_EXECUTABLE} -i ${INPUT_FILENAME} -o ${OUTPUT_FILENAME} ${ADDITIONAL_COMMAND_LINE_OPTIONS}
