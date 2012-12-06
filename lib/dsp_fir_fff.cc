/* -*- c++ -*- */
/*
 * Copyright 2004 Free Software Foundation, Inc.
 * 
 * This file is part of GNU Radio
 * 
 * GNU Radio is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 * 
 * GNU Radio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with GNU Radio; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

/*
 * config.h is generated by configure.  It contains the results
 * of probing for features, options etc.  It should be the first
 * file included in your .cc file.
 */
#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <dsp_fir_fff.h>
#include <gr_io_signature.h>
#include <gr_reverse.h>
//#include "cwt_support_func.h"
#include <gnuradio_beagleboard_dsp.h>
#include <gri_float_to_short.h>
#include <string.h>

/*
 * Create a new instance of howto_square2_ff and return
 * a boost shared_ptr.  This is effectively the public constructor.
 */
dsp_fir_fff_sptr 
dsp_make_fir_fff (const std::vector<float> &taps, short scale_data, short &interpolation, bufferType input_sig, bufferType output_sig, bufferType dsp_init_flag, bufferType fir_id)
{
  return dsp_fir_fff_sptr (new dsp_fir_fff (taps, scale_data, interpolation, input_sig, output_sig, dsp_init_flag, fir_id));
}

/*
 * Specify constraints on number of input and output streams.
 * This info is used to construct the input and output signatures
 * (2nd & 3rd args to gr_block's constructor).  The input and
 * output signatures are used by the runtime system to
 * check that a valid number and type of inputs and outputs
 * are connected to this block.  In this case, we accept
 * only 1 input and 1 output.
 */
static const int MIN_IN = 1;	// mininum number of input streams
static const int MAX_IN = 1;	// maximum number of input streams
static const int MIN_OUT = 1;	// minimum number of output streams
static const int MAX_OUT = 1;	// maximum number of output streams

/*
 * The private constructor
 */
 
 /*******************************************************************
 IMPORTANT IMPORTANT IMPORTANT
 
 THIS BLOCK IS NOT IMPLEMENTED ON THE DSP BECAUSE IT WAS
 UNNECESSARY FOR THE PSCR PERFORMANCE
 *******************************************************************/
dsp_fir_fff::dsp_fir_fff (const std::vector<float> &taps, 
			  short scale_data, 
			  short &interpolation, 
			  bufferType input_sig, 
			  bufferType output_sig, 
			  bufferType dsp_init_flag,
			  bufferType fir_id)
  : gr_sync_block ("dsp_fir_fff",
		   gr_make_io_signature (MIN_IN, MAX_IN, sizeof (float)),
		   gr_make_io_signature (MIN_OUT, MAX_OUT, sizeof (float)))
{
	std::vector<float> temp_taps;
	std::vector<short> d_taps_temp;
	short d_temp_buff_source[MAX_SIZE];
	short d_temp_buff_dest[MAX_SIZE];
	short coeff_size = taps.size();
	
	memset(d_temp_buff_source, 0, sizeof(d_temp_buff_source));
	memset(d_temp_buff_dest, 0, sizeof(d_temp_buff_dest));
						
	d_taps.resize(coeff_size);
	d_taps_temp.resize(coeff_size);	
	
	temp_taps = gr_reverse(taps);
        d_interpolation = interpolation;
        d_decimation = 1;
	dsp_float_to_short( coeff_size,
		d_taps, 
		temp_taps, 
		scale_data);
		
	copy_vector_to_buffer(d_temp_buff_source, d_taps);	
	d_scale_data = scale_data;
	d_input_sig = input_sig;
	d_output_sig = output_sig;
	d_fir_id = fir_id;
	d_ntaps = coeff_size;
#ifdef DEBUG	
//	fp = fopen("test.txt", "w");
	printf("COEFF Size = %d\n", coeff_size);
	printf("Ext TAPS = %f %f %f %f %f\n", taps[0], taps[1], taps[2], taps[3], taps[4]);
	printf("Temp TAPS = %f %f %f %f %f\n", temp_taps[0], temp_taps[1], temp_taps[2], temp_taps[3], temp_taps[4]);
	printf("D TAPS = %d %d %d %d %d\n", d_taps[0], d_taps[1], d_taps[2], d_taps[3], d_taps[4]);
#endif
	set_history (coeff_size);
	if (dsp_init_flag == 1)
	{
		printf("HEY INIT DSP FFF\n");	
		dsp_init_function("loopAl2.out");
	}
	else
		printf("HEY DON'T INIT DSP FFF\n");
	
	transmit_data_dsp(d_temp_buff_source, coeff_size, d_interpolation, d_decimation, d_fir_id);
       	receive_data_dsp(d_temp_buff_dest, coeff_size, d_fir_id);

#ifdef DEBUG		
	printf("Finished sending coefficients\n");
#endif	
	
  // nothing else required in this example
}

/*
 * Our virtual destructor.
 */
dsp_fir_fff::~dsp_fir_fff ()
{
  #ifdef DEBUG
  printf("Virtual Destructor\n");
  #endif
  // nothing else required in this example
}

//int 
//howto_square2_ff::howto_set_taps ()
//{
//	std::vector<short> taps_set(5,0);
//	taps_set[0] = 4;
//	taps_set[1] = 3;
//	taps_set[2] = 2;
//	taps_set[3] = 6;
//	taps_set[4] = 7;
//	
//	printf("%d %d %d %d %d\n", taps_set[0], taps_set[1], taps_set[2], taps_set[3], taps_set[4]);
//}

int 
dsp_fir_fff::work (int noutput_items,
			gr_vector_const_void_star &input_items,
			gr_vector_void_star &output_items)
{
  const float *in = (const float *) input_items[0];
  float *out = (float *) output_items[0];
  int one=0;
  char **two = NULL;
  
  #ifdef DEBUG
  printf("Before FIR Main\n");
  //for (int i = 0; i < 10; i++){
  //  //printf("input[%d] = %f\n",i, in[i]);
  //  fprintf(fp, "input[%d] = %f\n",i, in[i]);
  //}
    printf("input[0] = %f\n",in[0]);
    printf("input[1] = %f\n",in[1]);
    printf("input[2] = %f\n",in[2]);
    printf("input[3] = %f\n",in[3]);
    printf("input[4] = %f\n",in[4]);  
  #endif
  
  #ifdef DEBUG
  printf("sizeof float = %d sizeof int = %d sizeof double = %d\n", sizeof(float), sizeof(int), sizeof(double));
  #endif

 // if (set_mutex() == 1)
 // {
  	transmit_data_dsp_fs(in, (short &)noutput_items, d_scale_data, d_input_sig, d_output_sig, d_interpolation, d_decimation, d_ntaps, d_fir_id);
  	receive_data_dsp_fs(out, (short &)noutput_items, d_scale_data, d_input_sig, d_output_sig, d_fir_id);
  	//clear_mutex();
  	printf("MUTEX release CCF\n");
 // }
 // else
 // {
  //	#ifdef DEBUG
  //	printf("MUTEX is already locked CCF\n");
  //	#endif
  //	return 0;
  //}
  
  #ifdef DEBUG
  //fprintf(fp, "After FIR Main\n");
  //for (int i = 0; i < 10; i++){
    printf("output[0] = %f\n",out[0]);
    printf("output[1] = %f\n",out[1]);
    printf("output[2] = %f\n",out[2]);
    printf("output[3] = %f\n",out[3]);
    printf("output[4] = %f\n",out[4]);
    //fprintf(fp, "output[%d] = %f\n",i, out[i]);
  //}
  #endif

  // Tell runtime system how many output items we produced.
  return noutput_items;
}

int
dsp_fir_fff::dsp_float_to_short( short &nsamples,
		std::vector<short> &taps_dest, 
		const std::vector<float> &taps_source, 
		const short &scale)
{
	static const int MIN_SHORT = -32768;
	static const int MAX_SHORT =  32767;
	//const std::vector<float> in = taps_source[0];
	//std::vector<short> out = taps_dest[0];
	//gri_float_to_short (in, out, noutput_items);
	
	for (int i = 0; i < nsamples; i++){
    		long int r = (long int) rint (taps_source[i] * scale);
    		if (r < MIN_SHORT)
      			r = MIN_SHORT;
    		else if (r > MAX_SHORT)
      			r = MAX_SHORT;
    		taps_dest[i] = (short)r;
	}
	
	return NO_ERROR;
}

int
dsp_fir_fff::copy_vector_to_buffer(short *out, 
					const std::vector<short> in)
{
	int size = in.size();
	for (int i=0; i<size; i++)
	{
		out[i] = in[i];
	}
	
	return NO_ERROR;					
}
