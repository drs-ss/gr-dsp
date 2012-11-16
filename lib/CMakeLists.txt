# Copyright 2011 Free Software Foundation, Inc.
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Setup library
########################################################################
include(GrPlatform) #define LIB_SUFFIX

add_library(gnuradio-dsp SHARED
    #dsp_fir_fff.cc
    dsp_fir_ccf.cc
    dsp_fir_ccf_fm_demod.cc
    dsp_fir_ccf_fm_demod_decim.cc
    dsp_fir_ccf_fm_demod_deemph.cc
    dsp_fir_ccf_fm_mod.cc
    #dsp_fm_mod.cc
    dsp_init.cc
    dsp_clean.cc
)
target_link_libraries(gnuradio-dsp
    ${Boost_LIBRARIES}
    ${GRUEL_LIBRARIES}
    ${GNURADIO_CORE_LIBRARIES}
    ${EASYCOM_GPP_LIBRARIES}
)

set_target_properties(gnuradio-dsp PROPERTIES DEFINE_SYMBOL "gnuradio_dsp_EXPORTS")
set_target_properties(gnuradio-dsp PROPERTIES SOVERSION 0)
set_target_properties(gnuradio-dsp PROPERTIES VERSION 0.1)

########################################################################
# Install built library files
########################################################################
install(TARGETS gnuradio-dsp
    LIBRARY DESTINATION lib${LIB_SUFFIX} # .so/.dylib file
    ARCHIVE DESTINATION lib${LIB_SUFFIX} # .lib file
    RUNTIME DESTINATION bin              # .dll file
)
