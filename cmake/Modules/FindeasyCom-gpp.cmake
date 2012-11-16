########################################################################
# Find the library for the easyCom-gpp
########################################################################

INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_EASYCOM_GPP easycom-gpp)

FIND_PATH(
    EASYCOM_GPP_INCLUDE_DIRS
    NAMES gnuradio_beagleboard_dsp.h
    HINTS $ENV{EASYCOM_GPP_DIR}/include
        ${PC_EASYCOM_GPP_INCLUDEDIR}
    PATHS /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    EASYCOM_GPP_LIBRARIES
    NAMES loopgppAl2
    HINTS $ENV{EASYCOM_GPP_DIR}/lib
        ${PC_EASYCOM_GPP_LIBDIR}
    PATHS /usr/local/lib
          /usr/lib
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(EASYCOM_GPP DEFAULT_MSG EASYCOM_GPP_LIBRARIES EASYCOM_GPP_INCLUDE_DIRS)
MARK_AS_ADVANCED(EASYCOM_GPP_LIBRARIES EASYCOM_GPP_INCLUDE_DIRS)
