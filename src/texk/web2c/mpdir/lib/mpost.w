% $Id: mpost.w $
% MetaPost command-line program, by Taco Hoekwater.  Public domain.

\font\tenlogo=logo10 % font used for the METAFONT logo
\def\MP{{\tenlogo META}\-{\tenlogo POST}}

\def\title{MetaPost}

@* \[1] Metapost executable.

Now that all of \MP\ is a library, a separate program is needed to 
have our customary command-line interface. 

@ First, here are the C includes. |avl.h| is needed because of an 
avl_allocator that is defined in |mplib.h|

@d true 1
@d false 0
 
@c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "avl.h"
#include "mpbasictypes.h"
#include "mppstypes.h"
#include "mplib.h"
#define HAVE_BOOLEAN 1
#define HAVE_PROTOTYPES 1
#include <kpathsea/progname.h>
#include <kpathsea/tex-file.h>
#include <kpathsea/variable.h>
extern unsigned kpathsea_debug;
#include <kpathsea/concatn.h>
static string mpost_tex_program = "";

@ 
@c
void mpost_run_editor (MP mp, char *fname, int fline) {
  if (mp)
    fprintf(stdout,"Ok, bye (%s,%d)!",fname, fline);
  exit(1);
}

@ 
@<Register the callback routines@>=
mp->run_editor = mpost_run_editor;

@
@c 
string normalize_quotes (const char *name, const char *mesg) {
    boolean quoted = false;
    boolean must_quote = (strchr(name, ' ') != NULL);
    /* Leave room for quotes and NUL. */
    string ret = (string)xmalloc(strlen(name)+3);
    string p;
    const_string q;
    p = ret;
    if (must_quote)
        *p++ = '"';
    for (q = name; *q; q++) {
        if (*q == '"')
            quoted = !quoted;
        else
            *p++ = *q;
    }
    if (must_quote)
        *p++ = '"';
    *p = '\0';
    if (quoted) {
        fprintf(stderr, "! Unbalanced quotes in %s %s\n", mesg, name);
        exit(1);
    }
    return ret;
}


@ Invoke makempx (or troffmpx) to make sure there is an up-to-date
   .mpx file for a given .mp file.  (Original from John Hobby 3/14/90) 

@c

#ifndef MPXCOMMAND
#define MPXCOMMAND "makempx"
#endif
boolean mpost_run_make_mpx (MP mp, char *mpname, char *mpxname) {
  int ret;
  string cnf_cmd = kpse_var_value ("MPXCOMMAND");
  
  if (cnf_cmd && (strcmp (cnf_cmd, "0")==0)) {
    /* If they turned off this feature, just return success.  */
    ret = 0;

  } else {
    /* We will invoke something. Compile-time default if nothing else.  */
    string cmd;
    string qmpname = normalize_quotes(mpname, "mpname");
    string qmpxname = normalize_quotes(mpxname, "mpxname");
    if (!cnf_cmd)
      cnf_cmd = xstrdup (MPXCOMMAND);

    if (mp->troff_mode)
      cmd = concatn (cnf_cmd, " -troff ",
                     qmpname, " ", qmpxname, NULL);
    else if (mpost_tex_program && *mpost_tex_program)
      cmd = concatn (cnf_cmd, " -tex=", mpost_tex_program, " ",
                     qmpname, " ", qmpxname, NULL);
    else
      cmd = concatn (cnf_cmd, " -tex ", qmpname, " ", qmpxname, NULL);

    /* Run it.  */
    ret = system (cmd);
    free (cmd);
    free (qmpname);
    free (qmpxname);
  }

  free (cnf_cmd);
  return ret == 0;
}

@ 
@<Register the callback routines@>=
mp->run_make_mpx = mpost_run_make_mpx;


@ @c scaled mpost_get_random_seed (MP mp) {
  if (mp==NULL) exit(1); /* for -W */
#if defined (HAVE_GETTIMEOFDAY)
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return (tv.tv_usec + 1000000 * tv.tv_usec);
#elif defined (HAVE_FTIME)
  struct timeb tb;
  ftime(&tb);
  return (tb.millitm + 1000 * tb.time);
#else
  time_t clock = time ((time_t*)NULL);
  struct tm *tmptr = localtime(&clock);
  return (tmptr->tm_sec + 60*(tmptr->tm_min + 60*tmptr->tm_hour));
#endif
}

@ @<Register the callback routines@>=
mp->get_random_seed = mpost_get_random_seed;

@ 
@c char *mpost_find_file(char *fname, char *fmode, int ftype)  {
  char *s;
  int l ;
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
  return s;
}

@ 
@<Register the callback routines@>=
mp->find_file = mpost_find_file;

@ At the moment, the command line is very simple.

@d option_is(A) ((strncmp(argv[a],"--" A, strlen(A)+2)==0) || 
       (strncmp(argv[a],"-" A, strlen(A)+1)==0))
@d option_arg(B) (optarg && strncmp(optarg,B, strlen(B))==0)


@<Read and set commmand line options@>=
{
  char *optarg;
  while (++a<argc) {
    optarg = strstr(argv[a],"=") ;
    if (optarg!=NULL) {
      optarg++;
      if (!*optarg)  optarg=NULL;
    }
    if (option_is("ini")) {
      mp->ini_version = true;
    } else if (option_is ("kpathsea-debug")) {
      kpathsea_debug |= atoi (optarg);
    } else if (option_is("mem")) {
      mp->mem_name = xstrdup(optarg);
      if (!user_progname) 
	    user_progname = optarg;
    } else if (option_is("jobname")) {
      mp->job_name = xstrdup(optarg);
    } else if (option_is ("progname")) {
      user_progname = optarg;
    } else if (option_is("troff")) {
      mp->troff_mode = true;
    } else if (option_is ("tex")) {
      mpost_tex_program = optarg;
    } else if (option_is("interaction")) {
      if (option_arg("batchmode")) {
        mp->interaction = mp_batch_mode;
      } else if (option_arg("nonstopmode")) {
        mp->interaction = mp_nonstop_mode;
      } else if (option_arg("scrollmode")) {
        mp->interaction = mp_scroll_mode;
      } else if (option_arg("errorstopmode")) {
        mp->interaction = mp_error_stop_mode;
      } else {
        fprintf(stdout,"unknown option argument %s\n", argv[a]);
      }
    } else if (option_is("help")) {
      @<Show help and exit@>;
    } else if (option_is("version")) {
      @<Show version and exit@>;
    } else {
      break;
    }
  }
}

@ 
@<Show help...@>=
{
fprintf(stdout,
"\n"
"Usage: mpost [OPTION] [MPNAME[.mp]] [COMMANDS]\n"
"\n"
"  Run MetaPost on MPNAME, usually creating MPNAME.NNN (and perhaps\n"
"  MPNAME.tfm), where NNN are the character numbers generated.\n"
"  Any remaining COMMANDS are processed as MetaPost input,\n"
"  after MPNAME is read.\n"
"\n"
"  If no arguments or options are specified, prompt for input.\n"
"\n"
"  -ini                    be inimpost, for dumping mems\n"
"  -interaction=STRING     set interaction mode (STRING=batchmode/nonstopmode/\n"
"                          scrollmode/errorstopmode)\n"
"  -jobname=STRING         set the job name to STRING\n"
"  -progname=STRING        set program (and mem) name to STRING\n"
"  -tex=TEXPROGRAM         use TEXPROGRAM for text labels\n"
"  -kpathsea-debug=NUMBER  set path searching debugging flags according to\n"
"                          the bits of NUMBER\n"
"  -mem=MEMNAME            use MEMNAME instead of program name or a %%& line\n"
"  -troff                  set the prologues variable, use `makempx -troff'\n"
"  -help                   display this help and exit\n"
"  -version                output version information and exit\n"
"\n"
"Email bug reports to mp-implementors@@tug.org.\n"
"\n");
  exit(EXIT_SUCCESS);
}

@ 
@<Show version...@>=
{
fprintf(stdout,
"\n"
"MetaPost %s (CWeb version %s)\n"
"Copyright 2008 AT&T Bell Laboratories.\n"
"There is NO warranty.  Redistribution of this software is\n"
"covered by the terms of both the MetaPost copyright and\n"
"the Lesser GNU General Public License.\n"
"For more information about these matters, see the file\n"
"named COPYING and the MetaPost source.\n"
"Primary author of MetaPost: John Hobby.\n"
"Current maintainer of MetaPost: Taco Hoekwater.\n"
"\n", mp_metapost_version(mp), mp_mplib_version(mp));
  exit(EXIT_SUCCESS);
}

@ The final part of the command line, after option processing, is
stored in the \MP\ instance, this will be taken as the first line of
input.

@d command_line_size 256

@<Copy the rest of the command line@>=
{
  mp->command_line = malloc(command_line_size);
  if (mp->command_line==NULL) {
    fprintf(stderr,"Out of memory!\n");
    exit(EXIT_FAILURE);
  }
  strcpy(mp->command_line,"");
  if (a<argc) {
    k=0;
    for(;a<argc;a++) {
      char *c = argv[a];
      while (*c) {
	    if (k<(command_line_size-1)) {
          mp->command_line[k++] = *c;
        }
        c++;
      }
      mp->command_line[k++] = ' ';
    }
	while (k>0) {
      if (mp->command_line[(k-1)] == ' ') 
        k--; 
      else 
        break;
    }
    mp->command_line[k] = 0;
  }
}

@ Now this is really it: \MP\ starts and ends here.

@c 
int main (int argc, char **argv) { /* |start_here| */
  int a=0; /* argc counter */
  int k; /* index into buffer */
  int history; /* the exit status */
  /* If the user overrides argv[0] with -progname.  */
  char *user_progname = NULL;
  MP mp = mp_new();
  if (mp==NULL)
	exit(EXIT_FAILURE);
  mp->ini_version = false;
  @<Read and set commmand line options@>;
  kpse_set_program_name(argv[0],user_progname);
  @<Copy the rest of the command line@>;
  @<Register the callback routines@>;
  if(!mp_initialize(mp))
	exit(EXIT_FAILURE);
  mp_run(mp);
  history = mp->history;
  mp_free(mp);
  exit(history);
}

