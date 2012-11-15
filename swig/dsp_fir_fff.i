/* -*- c++ -*- */

%include "gnuradio.i"			// the common stuff

%{
#include "dsp_fir_fff.h"
%}

// ----------------------------------------------------------------

/*
 * First arg is the package prefix.
 * Second arg is the name of the class minus the prefix.
 *
 * This does some behind-the-scenes magic so we can
 * access howto_square_ff from python as howto.square_ff
 */

GR_SWIG_BLOCK_MAGIC(dsp,fir_fff);

 /*******************************************************************
 IMPORTANT IMPORTANT IMPORTANT
 
 THIS BLOCK IS NOT IMPLEMENTED ON THE DSP BECAUSE IT WAS
 UNNECESSARY FOR THE PSCR PERFORMANCE
 *******************************************************************/

dsp_fir_fff_sptr dsp_make_fir_fff (const std::vector<float> &taps, short scale_data, short interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);

class dsp_fir_fff : public gr_sync_interpolator
{
private:
  dsp_fir_fff (const std::vector<float> &taps, short scale_data, short &interpolation, short input_sig, short output_sig, short dsp_init_flag, short fir_id);
  //void set_taps (const std::vector<float> &taps);
  //void howto_set_taps ();
};

