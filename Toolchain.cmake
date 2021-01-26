# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)
SET(HOMEDIR "$ENV{HOME}/$ENV{DOCKERUSER}")

SET(TARGET_DIR ${HOMEDIR}/.leila/toolchains/raspberrypi0)
SET(TOOLCHAIN_DIR ${TARGET_DIR}/x-tools/arm-rpi-linux-gnueabihf)

# specify the cross compiler
SET(CMAKE_C_COMPILER
    ${TOOLCHAIN_DIR}/bin/arm-rpi-linux-gnueabihf-gcc)

SET(CMAKE_CXX_COMPILER
    ${TOOLCHAIN_DIR}/bin/arm-rpi-linux-gnueabihf-g++)

SET(CMAKE_LINKER
    ${TOOLCHAIN_DIR}/bin/arm-rpi-linux-gnueabihf-ld)

SET(CMAKE_STRIP
    ${TOOLCHAIN_DIR}/bin/arm-rpi-linux-gnueabihf-strip)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH
    ${TOOLCHAIN_DIR})

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(CMAKE_SYSROOT ${TOOLCHAIN_DIR}/arm-rpi-linux-gnueabihf/sysroot)
SET(SYSROOT_ARM ${CMAKE_SYSROOT})

SET(OpenCV_DIR "${HOMEDIR}/opencv/buildPi/install/lib/cmake/opencv4")
SET(QT5PI_PACKAGE "${TARGET_DIR}/qt/build/qt5pi/lib/cmake")
LIST(APPEND CMAKE_PREFIX_PATH 
"${TARGET_DIR}/build-raspicam-0.1.8/install"
"${QT5PI_PACKAGE}/Qt5"
"${QT5PI_PACKAGE}/Qt5Core"
"${QT5PI_PACKAGE}/Qt5Gui"
"${QT5PI_PACKAGE}/Qt5Widgets"
"${QT5PI_PACKAGE}/Qt5PrintSupport"
"${QT5PI_PACKAGE}/Qt5Charts"
"${QT5PI_PACKAGE}/Qt5DataVisualization"
"${QT5PI_PACKAGE}/Qt5OpenGL"
"${QT5PI_PACKAGE}/Qt5Xml"
"${QT5PI_PACKAGE}/Qt5Svg"
"${QT5PI_PACKAGE}/Qt5Network"
"${QT5PI_PACKAGE}/Qt5Concurrent"
"${QT5PI_PACKAGE}/DataVisualization"
"${TARGET_DIR}/qtcharts-everywhere-src-5.12.0/lib/cmake/Qt5Charts"
"${TARGET_DIR}/qtdatavis3d-everywhere-src-5.12.0/lib/cmake/Qt5DataVisualization"
)
