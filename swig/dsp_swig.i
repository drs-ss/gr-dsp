/* -*- c++ -*- */

#ifdef GR_HAVE_EASYCOM_GPP

#define DSP_API

%include "gnuradio.i"			// the common stuff


//load generated python docstrings
%include "dsp_swig_doc.i"

%{
#include <dsp_fir_ccf.h>
#include <dsp_fir_ccf_fm_demod.h>
#include <dsp_fir_ccf_fm_demod_deemph.h>
#include <dsp_fir_ccf_fm_demod_decim.h>
#include <dsp_fir_ccf_fm_mod.h>
#include <dsp_fir_fff.h>
%}

%inline %{
typedef short bufferType;
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
%include <dsp_fir_ccf.h>

// ----------------------------------------------------------------
GR_SWIG_BLOCK_MAGIC(dsp,fir_ccf_fm_demod);
%include <dsp_fir_ccf_fm_demod.h>

// ----------------------------------------------------------------
GR_SWIG_BLOCK_MAGIC(dsp,fir_ccf_fm_demod_decim);
%include <dsp_fir_ccf_fm_demod_decim.h>

// ----------------------------------------------------------------
//GR_SWIG_BLOCK_MAGIC(dsp,fir_fff);
//%include <dsp_fir_fff.h>

// ----------------------------------------------------------------
%{
#include <dsp_clean.h>
int clean(void){
    return dsp_clean();
}
%}
int clean(void);

// ----------------------------------------------------------------
%{
#include <dsp_init.h>
int init(void){
    return dsp_init();
}
%}
int init(void);

#if SWIGGUILE
%scheme %{
(load-extension-global "libguile-gnuradio-dsp_swig" "scm_init_gnuradio_dsp_swig_module")
%}

%goops %{
(use-modules (gnuradio gnuradio_core_runtime))
%}
#endif  /* SWIGGUILE */

#endif /* GR_HAVE_EASYCOM_GPP */
