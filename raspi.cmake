SET(CMAKE_SYSTEM_NAME Linux)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_C_COMPILER /raspi/rpi-tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER /raspi/rpi-tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/arm-linux-gnueabihf-g++)
SET(CMAKE_FIND_ROOT_PATH /raspi/rootfs)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

CMAKE_FORCE_C_COMPILER(arm-linux-gnueabihf-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(arm-linux-gnueabihf-g++ GNU)

set(CMAKE_CXX_LINK_FLAGS   "${CMAKE_CXX_LINK_FLAGS} --sysroot=${CMAKE_FIND_ROOT_PATH}")
set(CMAKE_C_LINK_FLAGS   "${CMAKE_C_LINK_FLAGS} --sysroot=${CMAKE_FIND_ROOT_PATH}")

