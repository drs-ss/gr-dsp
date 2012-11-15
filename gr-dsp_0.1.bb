# Based on the "gr-spi_0.2.bb" Recipe

DESCRIPTION = "DSP source/sink blocks for GNU Radio"
SECTION = "apps"
PRIORITY = "optional"
LICENSE = "GPLv3"
DEPENDS = "gnuradio python swig-native easycom-gpp"
RDEPENDS = "gnuradio easycom-gpp easycom-dsp"

inherit distutils-base cmake pkgconfig

export BUILD_SYS
export HOST_SYS="${MULTIMACH_TARGET_SYS}"

LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

PV = "0.1"

SRC_URI = "git://git.sigp.net/gr-dsp"
	    
S = "${WORKDIR}/git/gr-dsp"

FILES_${PN}-grc = "${datadir}/gnuradio/grc"

FILES_${PN} += "\
    ${PYTHON_SITEPACKAGES_DIR}/gnuradio/* \
    ${datadir}/gnuradio/* \
"

FILES_${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/gnuradio/.debug \
                    ${PYTHON_SITEPACKAGES_DIR}/gnuradio/*/.debug \
		   "
#FILES_${PN}-examples = "${datadir}/gnuradio/examples"

FILESPATHPKG_prepend = "${PN}-git:"

OECMAKE_BUILDPATH = "${S}/build"
OECMAKE_SOURCEPATH = "${S}"

EXTRA_OECMAKE = ""
EXTRA_OEMAKE = "-C ${OECMAKE_BUILDPATH}"
