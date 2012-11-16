/* -*- c++ -*- */

%include "gnuradio.i"			// the common stuff

%{
#include "dsp_init.h"
%}

// ----------------------------------------------------------------

/*
 * First arg is the package prefix.
 * Second arg is the name of the class minus the prefix.
 *
 * This does some behind-the-scenes magic so we can
 * access howto_square_ff from python as howto.square_ff
 */
//GR_SWIG_BLOCK_MAGIC(gr,dsp_init);
%rename(init) dsp_init;
/*
***********************************************************************
Description:
	This function clears of the DSP related resources allocated.
***********************************************************************	
Parameters:
	None
***********************************************************************	
Returns:
	1: For Success
***********************************************************************	
See Also:
	dsp_clean.i  -> SWIG wrapper for C++ function and tells how to call
			  block in Python
	dsp_clean.h  -> Header for C++ implementation
	dsp_init.i   -> SWIG wrapper for C++ function and tells how to call
			  block in Python
	dsp_init.h   -> Header for C++ implementation
	
***********************************************************************	
Notes:
	Calls the "dsp_init_function()" implemented
	in the GPP side library which is where the actual function is
	executed.
	
	the name of the DSP executable to be loaded is hardcoded in the
	C++ implementation of the block "/usr/share/easycom-dsp/loopAl2.out".  While it's hardcoded
	the function can be easily modified to pass the DSP executable 
	as a parameter
***********************************************************************	
References:
***********************************************************************	
Examples:
	example.py
	
	import gnuradio
	
	dsp_init();
***********************************************************************	
*/
int dsp_init();


