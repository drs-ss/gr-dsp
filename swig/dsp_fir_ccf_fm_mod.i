/* -*- c++ -*- */

%include "gnuradio.i"			// the common stuff

%{
#include "dsp_fir_ccf_fm_mod.h"
%}

// ----------------------------------------------------------------

/*
 * First arg is the package prefix.
 * Second arg is the name of the class minus the prefix.
 *
 * This does some behind-the-scenes magic so we can
 * access howto_square_ff from python as howto.square_ff
 */
GR_SWIG_BLOCK_MAGIC(dsp,fir_ccf_fm_mod);
  /*
***********************************************************************
Description:
	This function sets up an FM modulator block followed by a complex 
	FIR filter with real coefficients on the DSP.
	     -----------------      -------
   INPUT---> | FM Modulation | ---> | FIR | ---> OUTPUT
	     -----------------      -------
***********************************************************************	
Parameters:
	taps          = Filter Coefficients
	scale_data    = Scaling factor for floating/fixed point conversion
	interpolation = Interpolation factor to be implemented on the DSP
	input_sig     = 0-> input is floating point and needs to be converted
			1-> input is fixed point and can be passed as is
	output_sig    = 0-> output should be converted to floating point
			1-> output should be kept as fixed point
	dsp_init_flag = 0-> don't initialize DSP
			1-> initialize the DSP
	fir_id        = unique block ID for this block should be an integer number
	
***********************************************************************	
Returns:
	None
***********************************************************************	
See Also:
	dsp_fir_ccf_fm_mod.i  -> SWIG wrapper for C++ implementation
	dsp_fir_ccf_fm_mod.h  -> Header for C++ implementation
***********************************************************************	
Notes:
	dsp_init_flag is for legacy support the dsp_init function should
	be used to initialize the DSP.
	
	The current implementation restricts the tap size to less than
	500 taps because the GPP library implementation of the transmit
	function used doesn't fragment the taps if they exceed this limit.
	
	FM phase limit is hardcoded in the DSP program though it can be easily
	parametrized and passed from python 
	
	
***********************************************************************	
References:
***********************************************************************	
Examples:
	example.py
	
	import gnuradio
	
	taps = {1, 2, 3, 4}
	scale_data    = 15	# data should be scaled by 2^15
	interpolation = 1       # no decimation is needed
	input_sig     = 0       # input if floating point
	output_sig    = 0       # output should in floating point format
	dsp_init      = 0       # don't init DSP
	fir_id        = 0
	
	dsp_init()
	dsp_fir_fm_mod = dsp_fir_ccf_fm_mod(taps, scale_data, interpolation, input_sig, output_sig, dsp_init, fir_id);
	
	connect(src, dsp_fir_fm_mod, sink)
***********************************************************************	
*/
dsp_fir_ccf_fm_mod_sptr dsp_make_fir_ccf_fm_mod (const std::vector<float> &taps, short scale_data, short interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);

//enum io_sig_type {
//    FLOATING_POINT = 0,
//    FIXED_POINT = 1,
//  };
  
class dsp_fir_ccf_fm_mod : public gr_block
{
private:
  dsp_fir_ccf_fm_mod (const std::vector<float> &taps, short scale_data, short interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);
};

// ----------------------------------------------------------------

