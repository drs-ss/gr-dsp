# Copyright 2011 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it anor modify
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
# Install public header files
########################################################################
install(FILES
    dsp_fir_fff.h
    dsp_fir_ccf.h
    dsp_fir_ccf_fm_demod.h
    dsp_fir_ccf_fm_demod_deemph.h
    dsp_fir_ccf_fm_demod_decim.h
    dsp_fir_ccf_fm_mod.h
    #dsp_fm_mod.h
    dsp_init.h
    dsp_clean.h
    #dsp_api.h
    DESTINATION include/gnuradio
)
