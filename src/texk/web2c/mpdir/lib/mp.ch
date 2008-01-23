@x
#include <unistd.h> /* for access() */
#include "avl.h"
#include "mplib.h"
@y
#include "avl.h"
#include "mplib.h"
#define HAVE_BOOLEAN 1
#define HAVE_PROTOTYPES 1
#include <kpathsea/progname.h>
#include <kpathsea/tex-file.h>
@z

@x
  mp->term_out = stdout;
@y
  mp->term_out = stdout;
  kpse_set_program_name("mpost","mpost");
@z

@x
FILE *mp_open_file(MP mp, char *fname, char *fmode, int ftype)  {
    assert(mp); assert(ftype);
	return fopen(fname, fmode);
}
@y
FILE *mp_open_file(MP mp, char *fname, char *fmode, int ftype)  {
  char *s;
  int l ;
  FILE *f = NULL;
  assert(mp); 
  s = fname; /* when writing */
  if (fmode[0]=='r') {
    switch(ftype) {
    case mp_filetype_program: 
      l = strlen(fname);
   	  if (l>3 && strcmp(fname+l-3,".mf")==0) {
   	    s = kpse_find_file (fname, kpse_mf_format, 0); 
      } else {
   	    s = kpse_find_file (fname, kpse_mp_format, 0); 
      }
      break;
    case mp_filetype_text: 
      s = kpse_find_file (fname, kpse_mp_format, 0); 
      break;
    case mp_filetype_memfile: 
      s = kpse_find_file (fname, kpse_mem_format, 0); 
      break;
    case mp_filetype_metrics: 
      s = kpse_find_file (fname, kpse_tfm_format, 0); 
      break;
    case mp_filetype_fontmap: 
      s = kpse_find_file (fname, kpse_fontmap_format, 0); 
      break;
    case mp_filetype_font: 
      s = kpse_find_file (fname, kpse_type1_format, 0); 
      break;
    case mp_filetype_encoding: 
      s = kpse_find_file (fname, kpse_enc_format, 0); 
      break;
    }
  }
  f = fopen(s,fmode);
  return f;
}
@z

@x
            if (access (p->tfm_name,R_OK)) {
@y
            if (kpse_find_file (p->tfm_name, kpse_tfm_format, 0)) {
@z

@x
    if (access("mpost.map", R_OK)) {
@y
    if (kpse_find_file ("mpost.map", kpse_fontmap_format, 0)) {
@z

