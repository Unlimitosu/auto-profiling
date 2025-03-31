#!/bin/bash

BUILD_DIR="./build"
PROFILE_RESDIR="./profile_result"
EXEC_FILE=""

mkdir $BUILD_DIR > /dev/null 2>&1
make clean
make

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: 확장자가 없는 실행 파일 우선, 없으면 *.out 파일 사용
    EXEC_FILE=$(find "$BUILD_DIR" -type f -perm -u+x ! -name "*.*" -print -quit)
    [ -z "$EXEC_FILE" ] && EXEC_FILE=$(find "$BUILD_DIR" -type f -name "*.out" -perm -u+x -print -quit)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux: 확장자 없는 실행 파일 검색
    EXEC_FILE=$(find "$BUILD_DIR" -type f -executable ! -name "*.*" -print -quit)
else 
    echo "ERROR: Unsupported OS"
    exit 1
fi

if [ -z "$EXEC_FILE" ]; then
    echo "Executable file not found"
    exit 1
fi

echo "Executable file detected: $EXEC_FILE"
echo "Enter a file name:"
read PDF_NAME
echo "Try to generate profiled file as $PDF_NAME.pdf"

./$EXEC_FILE
mkdir profile_result > /dev/null 2>&1
mv -f gmon.out $PROFILE_RESDIR  # force move
gprof $EXEC_FILE $PROFILE_RESDIR/gmon.out > $PROFILE_RESDIR/$PDF_NAME.txt
python3 -m gprof2dot -f prof $PROFILE_RESDIR/$PDF_NAME.txt | dot -Tpdf -o $PROFILE_RESDIR/$PDF_NAME.pdf
echo "Generated $PROFILE_RESDIR/$PDF_NAME.pdf"
