.PHONY: all build cmake flash debug clean

PROCESSES := 8
BUILD_DIR := build
BUILD_TYPE ?= Debug
BUILD_NAME := joylrs

all: build

${BUILD_DIR}/Makefile:
	cmake \
		-B${BUILD_DIR} \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cmake: ${BUILD_DIR}/Makefile

build: cmake
	$(MAKE) -j ${PROCESSES} -C ${BUILD_DIR} --no-print-directory

${BUILD_DIR}/joylrs.bin: build
${BUILD_DIR}/joylrs.elf: build

flash: ${BUILD_DIR}/joylrs.bin
	./tools/rp2040-flash ${BUILD_DIR}/joylrs.bin

debug: ${BUILD_DIR}/joylrs.elf
	./tools/rp2040-debug ${BUILD_DIR}/joylrs.elf

clean:
	rm -rf $(BUILD_DIR)
