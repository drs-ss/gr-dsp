/* -*- c++ -*- */

%include "gnuradio.i"			// the common stuff

%{
#include "dsp_fir_ccf.h"
%}

// ----------------------------------------------------------------

/*
 * First arg is the package prefix.
 * Second arg is the name of the class minus the prefix.
 *
 * This does some behind-the-scenes magic so we can
 * access howto_square_ff from python as howto.square_ff
 */
GR_SWIG_BLOCK_MAGIC(dsp,fir_ccf);
/*
***********************************************************************
Description:
	This function sets up a complex RF data input and output FIR
	filter with real coefficients on the DSP.
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
	dsp_fir_ccf.cc -> C++ implementation of function
	dsp_fir_ccf.h  -> Header for C++ implementation
***********************************************************************	
Notes:
	dsp_init_flag is for legacy support the dsp_init function should
	be used to initialize the DSP.
	
	The current implementation restricts the tap size to less than
	500 taps because the GPP library implementation of the transmit
	function used doesn't fragment the taps if they exceed this limit.
	
	
***********************************************************************	
References:
***********************************************************************	
Examples:
	example.py
	
	import gnuradio
	
	taps = {1, 2, 3, 4}
	scale_data    = 15	# data should be scaled by 2^15
	interpolation = 1       # no interpolation is needed
	input_sig     = 0       # input if floating point
	output_sig    = 0       # output should in floating point format
	dsp_init      = 0       # don't init DSP
	fir_id        = 0
	
	dsp_init()
	dsp_fir = dsp_fir_ccf(taps, scale_data, interpolation, input_sig, output_sig, dsp_init, fir_id);
	
	connect(src, dsp_fir, sink)
***********************************************************************	
*/
dsp_fir_ccf_sptr dsp_make_fir_ccf (const std::vector<float> &taps, short scale_data, short interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);

//enum io_sig_type {
//    FLOATING_POINT = 0,
//    FIXED_POINT = 1,
//  };

// class definition  
class dsp_fir_ccf : public gr_block
{
private:
  dsp_fir_ccf (const std::vector<float> &taps, short scale_data, short interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);
};

// ----------------------------------------------------------------

