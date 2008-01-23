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
#include "avl.h"
#include "mplib.h"


@ At the moment, the command line is very simple.

@d option_is(A) ((strcmp(argv[a],"--" A)==0) || 
       (strcmp(argv[a],"-" A)==0))

@<Read and set commmand line options@>=
while (++a<argc) {
  if (option_is("ini")) {
     mp->ini_version = true;
  } else if (option_is("troff")) {
     mp->troff_mode = true;
  } else if (option_is("help")) {
    @<Show help and exit@>;
  } else if (option_is("version")) {
    @<Show version and exit@>;
  } else {
    break;
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
"  -ini           be inimpost, for dumping mems\n"
"  -troff         set the prologues variable, use `makempx -troff'\n"
"  -help          display this help and exit\n"
"  -version       output version information and exit\n"
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
  MP mp = mp_new();
  if (mp==NULL)
	exit(EXIT_FAILURE);
  mp->ini_version = false;
  mp->job_id_string = NULL;
  @<Read and set commmand line options@>;
  @<Copy the rest of the command line@>;
  if(!mp_initialize(mp))
	exit(EXIT_FAILURE);
  mp_run(mp);
  history = mp->history;
  mp_free(mp);
  exit(history);
}

