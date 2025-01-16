#!/bin/bash

set -x
set -u 

PATH_TO_EXECUTABLE="../build/src/apps/ojph_expand/ojph_expand"
#INPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-true.colour-transf-true.j2c"
#OUTPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-true.colour-transf-true.j2c.exr"
#INPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-true.colour-transf-false.j2c"
#OUTPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-true.colour-transf-false.j2c.exr"
#INPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-false.qstep-0.025.colour-transf-true.j2c"
#OUTPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-false.qstep-0.025.colour-transf-true.j2c.exr"
INPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-false.qstep-0.025.colour-transf-false.j2c"
OUTPUT_FILENAME="/tmp/SPARKS_ACES_06822.exr.reversible-false.qstep-0.025.colour-transf-false.j2c.exr"
ADDITIONAL_COMMAND_LINE_OPTIONS=""

valgrind -s --error-exitcode=1 --leak-check=full --track-origins=yes --show-leak-kinds=all ${PATH_TO_EXECUTABLE} -i ${INPUT_FILENAME} -o ${OUTPUT_FILENAME} ${ADDITIONAL_COMMAND_LINE_OPTIONS}


