/* -*- c++ -*- */

%include "gnuradio.i"			// the common stuff

%{
#include "dsp_clean.h"
%}

// ----------------------------------------------------------------

/*
 * First arg is the package prefix.
 * Second arg is the name of the class minus the prefix.
 *
 * This does some behind-the-scenes magic so we can
 * access howto_square_ff from python as howto.square_ff
 */
//GR_SWIG_BLOCK_MAGIC(gr,dsp_clean);

// ----------------------------------------------------------------
%rename(clean) dsp_clean;
//%rename(clean) dsp_clean;
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
	dsp_clean.cc -> C++ implementation of function
	dsp_clean.h  -> Header for C++ implementation
	dsp_init.i   -> SWIG wrapper for C++ function and tells how to call
			  block in Python
	dsp_init.h   -> Header for C++ implementation
	
***********************************************************************	
Notes:
	This Python block calls the "dsp_clean_function()" implemented
	in the GPP side library which is where the actual function is
	executed.
***********************************************************************	
References:
***********************************************************************	
Examples:
	example.py
	
	import gnuradio
	
	dsp_clean();
***********************************************************************	
*/

int dsp_clean();


