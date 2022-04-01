.PHONY: all build cmake flash debug clean

PROCESSES := 8
BUILD_DIR := build
BUILD_TYPE ?= Debug
BUILD_NAME := hello

all: build

${BUILD_DIR}/Makefile: CMakeLists.txt
	cmake \
		-B${BUILD_DIR} \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE}

cmake: ${BUILD_DIR}/Makefile

build: cmake
	cmake --build ${BUILD_DIR} --target all -- -j ${PROCESSES}

${BUILD_DIR}/${BUILD_NAME}.hex: build
${BUILD_DIR}/${BUILD_NAME}.elf: build

flash: ${BUILD_DIR}/${BUILD_NAME}.hex
	./tools/jlink-flash ${BUILD_DIR}/${BUILD_NAME}.hex

debug: ${BUILD_DIR}/${BUILD_NAME}.elf
	./tools/jlink-debug ${BUILD_DIR}/${BUILD_NAME}.elf

clean:
	rm -rf $(BUILD_DIR)
