# 컴파일러 및 컴파일 옵션
CC      = gcc
CFLAGS  = -Wall -Wextra -I -pg -O3

# 현재 디렉토리의 모든 .c 파일을 대상으로 함
SRC     = $(wildcard *.c)
# 각 .c 파일에 대해 build 디렉토리 내 .o 파일을 생성
OBJ     = $(patsubst %.c, build/%.o, $(SRC))
# 최종 실행 파일은 build 디렉토리 내에 생성
TARGET  = build/main

.PHONY: all clean

# 기본 타깃: 실행 파일 생성
all: $(TARGET)

# 실행 파일 링크: 빌드 디렉토리 생성 후 객체 파일들을 링크
$(TARGET): $(OBJ)
	@mkdir -p build
	$(CC) $(OBJ) -o $(TARGET)

# 패턴 규칙: 각 .c 파일을 빌드 디렉토리 내 .o 파일로 컴파일
build/%.o: %.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

# 클린: build 디렉토리 삭제
clean:
	rm -rf build
