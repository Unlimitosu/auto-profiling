#!/bin/bash

BUILD_DIR="./build"
EXEC_FILE=""
EXEC_FILE2=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    EXEC_FILE=$(find "$BUILD_DIR" -type f -name "*.out" -perm -u+x -print -quit)
    EXEC_FILE2=$(find "$BUILD_DIR" -type f -perm -u+x ! -name "*.*" -print -quit)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    EXEC_FILE=$(find "$BUILD_DIR" -type f -executable ! -name "*.*" -print -quit)
else 
    echo "ERROR: Unsupported OS"
    exit 1
fi

if [ -n "$EXEC_FILE2" ]; then
    EXEC_FILE=$EXEC_FILE2
elif [ -z "$EXEC_FILE" ]; then
    echo "Executable file not found"
    exit 1
fi

echo "Executable file detected: $EXEC_FILE"
echo "Enter a file name:"
read PDF_NAME
echo "Try to generate profiled file as $PDF_NAME.pdf"

make clean
make
./$EXEC_FILE
mkdir profile_result > /dev/null 2>&1
gprof $EXEC_FILE gmon.out > /profile_result/$PDF_NAME.txt
python3 -m gprof2dot -f gprof /profile_result/$PDF_NAME.txt | dot -Tpdf -o /profile_result/$PDF_NAME.pdf

