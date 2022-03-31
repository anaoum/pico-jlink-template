cmake_minimum_required(VERSION 3.13)

set(PICO_COMPILER pico_arm_gcc)
set(PICO_PLATFORM rp2040)
set(PICO_BOARD pico)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

include("$ENV{PICO_SDK_PATH}/pico_sdk_init.cmake")
add_subdirectory("lib/pico-stdio-rtt")

project(hello C CXX ASM)

pico_sdk_init()

add_executable(${PROJECT_NAME}
    src/main.c
)
add_compile_options(-Wall)

target_link_libraries(${PROJECT_NAME}
    pico_stdlib
    pico_stdio_rtt
)

pico_enable_stdio_uart(${PROJECT_NAME} 0)
pico_enable_stdio_usb(${PROJECT_NAME} 0)
pico_enable_stdio_semihosting(${PROJECT_NAME} 0)

pico_set_program_name(${PROJECT_NAME} ${PROJECT_NAME})
pico_set_program_version(${PROJECT_NAME} "0.1")
pico_add_extra_outputs(${PROJECT_NAME})
