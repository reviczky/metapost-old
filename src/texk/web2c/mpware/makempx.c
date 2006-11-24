/* $Id$

 Make an MPX file from the labels in a MetaPost source file,
 using mpto and either dvitomp (TeX) or dmp (troff).

 Started from a shell script initially based on John Hobby's original
 version, thatr was then translated to C by Akira Kakuto (Aug 1997, 
 Aug 2001), and updated and largely rewritten by Taco Hoekwarer (Nov 2006).

 Public Domain.
*/

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#ifdef WIN32
 #include <io.h>
 #include <process.h>
#else
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
#endif
#include <string.h>
#include <ctype.h>

#include <kpathsea/kpathsea.h>

#define version "0.991"

#define ERRLOG "mpxerr.log"
#define TEXERR "mpxerr.tex"
#define DVIERR "mpxerr.dvi"
#define TROFF_INERR "mpxerr"
#define TROFF_OUTERR "mpxerr.t"

#define DMP "dmp"
#define DVITOMP "dvitomp"
#define NEWER "newer"
#define MPTO "mpto" 
#define MPTOTEXOPT "-tex"
#define MPTOTROPT  "-troff"
#define TROFF   "soelim -k | eqn -Tps -d\\$\\$ | troff -Tps"
#define TEX     "tex"

#ifdef WIN32
#define nuldev "nul"
#define ACCESS_MODE 4
#define DUP _dup
#define DUPP _dup2
#define uexit exit
#else
#define nuldev "/dev/null"
#define ACCESS_MODE R_OK
#define DUP dup
#define DUPP dup2
#define uexit _exit
#endif

#define ARGUMENT_IS(a) (!strncmp(av[curarg],(a),strlen((a))))
  
/* TeX command name */
char maincmd[256];

void usage(char *name)
{
  fprintf(stderr,"Usage: %s [-tex|-tex=<program>|-troff] MPFILE MPXFILE.\n", name);
  fputs("  If MPXFILE is older than MPFILE, translate the labels from the MetaPost\n"
  "  input file MPFILE to low-level commands in MPXFILE, by running\n"
  "    "  MPTO " " MPTOTEXOPT ", " TEX ", and " DVITOMP "\n"
  "  by default; or, if -troff is specified,\n"
  "    "  MPTO " " MPTOTROPT ", " TROFF ", and " DMP ".\n\n"
  "  The current directory is used for writing temporary files.  Errors are\n"
  "  left in mpxerr.{tex,log,dvi}.\n\n"
  "  If the file named in $MPTEXPRE (mptexpre.tex by default) exists, it is\n"
  "  prepended to the output in tex mode.\n\n"
  "Email bug reports to metapost@tug.org.\n",stderr);
  uexit (0);
}

void mess(char *progname)
{
  fprintf(stderr, "Try `%s --help' for more information.\n", progname);
  uexit (1);
}


#define MBUF 512
#define LNAM 256
#define SNAM 128

/* Temporary files */
char mp_tex[SNAM], mp_i[SNAM], mp_t[SNAM], mp_tmp[SNAM], mp_log[SNAM];

void erasetmp(void)
{
  char wrk[SNAM];
  char *p;

  if(mp_tex[0]) {
     remove(mp_tex);
     strcpy(wrk, mp_tex);
     if((p = strrchr(wrk, '.'))) *p = '\0';
     strcat(wrk,".aux");
     remove(wrk);
  }
  if(mp_i[0]) {
     remove(mp_i);
  }
  if(mp_t[0]) {
     remove(mp_t);
  }
  if(mp_tmp[0]) {
     remove(mp_tmp);
     strcpy(wrk, mp_tmp);
     if((p = strrchr(wrk, '.'))) *p = '\0';
     strcat(wrk,".aux");
     remove(wrk);
  }
  if(mp_log[0]) {
     remove(mp_log);
  }
}

FILE * 
makempx_xfopen(char *name, char *mode) {
  FILE * ret;
  if(!(ret = fopen(name,mode))) {
	if (*mode == 'r') {
	  fprintf(stderr, "Cannot open %s for reading.\n", name);
	} else {
	  fprintf(stderr, "Cannot open %s for writing.\n", name);
	}
	erasetmp();
	uexit (1);
  }
  return ret;
}


int run_command (int count, char **cmdl) {
  int retcode = 0;
  char *cmd = NULL;
  char **options = NULL;
  int i = 0; /* for loops */
#ifndef WIN32
  pid_t child;
#endif
  options = xmalloc(sizeof(char *)*(count+1));
  cmd = strdup(cmdl[0]);
  while (i<count) { options[i] = cmdl[i]; i++;  }
  options[count] = NULL;
#ifndef WIN32
  child = fork();
  if (child>=0) {
	if (child==0) {
	  execvp(cmd,options);
	} else
	  wait(&retcode);
  }
  free(cmd);
  free(options);
  return WEXITSTATUS(retcode);
#else
  retcode = spawnvp(P_WAIT, cmd, options);
  free(cmd);
  free(options);
  return retcode;
#endif
}

int do_split_command (char *maincmd, char **cmdline, char target) {
  char *piece;
  char cmd[SNAM];
  int ret = 0;
  int i;
  int in_string = 0;
  if (strlen(maincmd)==0)
	return 0 ;
  strcpy(cmd, maincmd);
  i=0;
  while (cmd[i] == ' ') i++;
  piece = cmd;
  for (;i<strlen(maincmd);i++) {
	if (in_string==1) {
	  if (cmd[i]== '"') {
		in_string = 0;
	  }
	} else if (in_string==2) {
	  if (cmd[i]== '\'') {
		in_string = 0;
	  }
	} else {
	  if (cmd[i]== '"') {
		in_string = 1;
	  } else if (cmd[i]== '\'') {
		in_string = 2;
	  } else if (cmd[i] == target) {
		cmd[i] = 0;;
		cmdline[ret++] = strdup(piece);
		while (cmd[(i+1)] == ' ') i++;
		piece = cmd+(i+1);
	  }
	}
  }
  if (*piece) {
	cmdline[ret++] = piece;
  }
  return ret;
}

int split_command (char *maincmd, char **cmdline) {
  return do_split_command(maincmd,cmdline,' ');
}

int split_pipes (char *maincmd, char **cmdline) {
  return do_split_command(maincmd,cmdline,'|');
}

int main(int ac, char **av)
{
  int  mpmode = 0;
  char tmpname[] = "mpxXXXXXX";
  char *progname;

  char buffer[MBUF];
  char mpfile[LNAM], mpxfile[LNAM], mptexpre[LNAM];
  char whatever_to_mpx[SNAM];
  char infile[SNAM], inerror[SNAM];

  char *env = NULL;
  /* max 10! */
  char *cmdline[] = {NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
  char *cmdbits[] = {NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
  int cmdlength = 1;
  int cmdbitlength = 1;

  int retcode, i, sav_o, sav_e, sav_i;

  FILE *fr, *fw, *few, *fnulr, *fnulw;

  int curarg = 0;
  mpfile[0] = 0;
  mpxfile[0] = 0;

#ifdef WIN32
  getlongname(av[0]);
#endif
  progname = av[0];
  
  /* Initialize buffer for temporary file names */
  for(i = 0; i < SNAM; i++) {
    mp_tex[i] = '\0';
    mp_i[i] = '\0';
    mp_t[i] = '\0';
    mp_tmp[i] = '\0';
    mp_log[i] = '\0';
  }

  kpse_set_progname(progname);

  while (curarg < (ac-1)) {
	curarg++;
	/* Set TeX command */
	if((env = kpse_var_value("TEX")))
	  strcpy(maincmd, env);
	else if((env = kpse_var_value("MPXMAINCMD")))
	  strcpy(maincmd, env);
	else
	  strcpy(maincmd, TEX);
	if(env) free(env);
	strcat(maincmd," --parse-first-line --interaction=nonstopmode ");
	if (ARGUMENT_IS("-help") || ARGUMENT_IS("--help")) {
	  usage(av[0]);
	} else if (ARGUMENT_IS("-version") || ARGUMENT_IS("--version")) {
	  fprintf (stdout,"%s %s\n", progname, version);
	  fputs ("There is NO warranty. This program is in the public domain.\n"
             "Original author: John Hobby.\n"
             "Current maintainer: Taco Hoekwater.\n", stdout);
	  uexit (0);
    } else if(ARGUMENT_IS("-troff") || ARGUMENT_IS("--troff")) {
      mpmode = 1;
	  
      if (ARGUMENT_IS("-troff=")  || ARGUMENT_IS("--troff=")) {
		i = 7; 
		if (*(av[curarg] + i) == '=') 
		  i++;
		if (*(av[curarg] + i) == '\'' || *(av[curarg] + i) == '\"') {
		  strcpy(maincmd, av[curarg] + i + 1);
		  *(maincmd+strlen(maincmd)) = 0;
		} else {
		  strcpy(maincmd, av[curarg] + i);
		}
	  } else { 
		strcpy(maincmd,TROFF);
	  }
	  
    } else if(ARGUMENT_IS("-tex") || ARGUMENT_IS("--tex")) {
      mpmode = 0;

      if (ARGUMENT_IS("-tex=")  || ARGUMENT_IS("--tex=")) {
		i = 5; 
		if (*(av[curarg] + i) == '=') 
		  i++;
		if (*(av[curarg] + i) == '\'' || *(av[curarg] + i) == '\"') {
		  strcpy(maincmd, av[curarg] + i + 1);
		  *(maincmd+strlen(maincmd)) = 0;
		} else {
		  strcpy(maincmd, av[curarg] + i);
		}
	  }

    } else if(ARGUMENT_IS("-")) {
	  fprintf(stderr, "%s: Invalid option: %s.\n", progname, av[curarg]);
	  mess(progname);
	} else {
	  if (mpfile[0] == 0) {
		if(strchr(av[curarg], ' ') && (av[curarg][0] != '\"')) {
		  strcpy(mpfile, "\"");
		  strcat(mpfile, av[curarg]);
		  strcat(mpfile, "\"");
		} else strcpy(mpfile, av[curarg]);
	  } else if (mpxfile[0] == 0) {
		if(strchr(av[curarg], ' ') && (av[curarg][0] != '\"')) {
		  strcpy(mpxfile, "\"");
		  strcat(mpxfile, av[curarg]);
		  strcat(mpxfile, "\"");
		} else strcpy(mpxfile, av[curarg]);
	  } else {
		fprintf(stderr, "%s: Extra argument %s.\n", progname, av[curarg]);
		mess(progname);
	  }
	}
  }

  if (mpfile[0] == 0 || mpxfile[0] == 0) {
	fprintf(stderr, "%s: Need exactly two file arguments.\n", progname);
	mess(progname);
  }

  /* 
     The shell script trapped HUP, INT, QUIT and TERM for cleaning up 
     temporary files.
     That is not portable, so the C version does not attempt to do so.
   */

  /* Check if mpfile is newer than mpxfile */

  cmdline[0] = NEWER;
  cmdline[1] = mpfile;
  cmdline[2] = mpxfile;
  retcode = run_command(3,cmdline);

  /* If MPX file is up-to-date or if MP file does not exist, do nothing. */
  if(retcode) uexit (0);
  
  i = mkstemp(tmpname);
  if(i==-1)
	uexit(1);

  close(i);
  remove(tmpname);

  strcpy(mp_tex, tmpname);
  strcat(mp_tex, ".tex");

  /* step 1: */

  fw = makempx_xfopen(mp_tex,"wb");
  few = makempx_xfopen(ERRLOG,"wb");

  cmdline[0] = MPTO;
  cmdline[1] = (mpmode == 0 ? MPTOTEXOPT : MPTOTROPT);
  cmdline[2] = mpfile;

  sav_o = DUP(fileno(stdout));
  DUPP(fileno(fw), fileno(stdout));
  sav_e = DUP(fileno(stderr));
  DUPP(fileno(few), fileno(stderr));

  retcode = run_command(3,cmdline);

  DUPP(sav_o, fileno(stdout));
  close(sav_o);
  fclose(fw); 

  DUPP(sav_e, fileno(stderr));
  close(sav_e);
  fclose(few);

  if(retcode) {
    fprintf(stderr, "%s: Command failed: %s %s %s\n",
			 progname, cmdline[0], cmdline[1], cmdline[2]);
    erasetmp();
    uexit (1);
  }

  /* step 2: */

  if(mpmode == 0) {   /* TeX mode */
    if((env = getenv("MPTEXPRE"))) strcpy(mptexpre, env);
    else if((env = kpse_var_value("MPTEXPRE"))) strcpy(mptexpre, env);
    else strcpy(mptexpre, "mptexpre.tex");

    if(!access(mptexpre, ACCESS_MODE)) {
      strcpy(mp_tmp, tmpname);
      strcat(mp_tmp, ".tmp");
	  fr = makempx_xfopen(mptexpre, "r");
      fw = makempx_xfopen(mp_tmp,"wb");

      while((i = fread(buffer, 1, MBUF, fr)))
        fwrite(buffer, 1, i, fw);
      fclose(fr);
	  fr = makempx_xfopen(mp_tex,"r");
      while((i = fread(buffer, 1, MBUF, fr)))
        fwrite(buffer, 1, i, fw);
      fclose(fr); 
	  fclose(fw);

      remove(mp_tex); rename(mp_tmp, mp_tex);
    }
	strcat(maincmd, mp_tex);
	cmdlength = split_command(maincmd, cmdline);
    
	fnulr = makempx_xfopen(nuldev, "r");
	fnulw = makempx_xfopen(nuldev, "w");

    sav_i = DUP(fileno(stdin));
    sav_o = DUP(fileno(stdout));
    DUPP(fileno(fnulr), fileno(stdin));
    DUPP(fileno(fnulw), fileno(stdout));

	retcode = run_command(cmdlength,cmdline);

    DUPP(sav_i, fileno(stdin));
    close(sav_i);
    DUPP(sav_o, fileno(stdout));
    close(sav_o);
    fclose(fnulr); fclose(fnulw);

    if(!retcode) {
      strcpy(whatever_to_mpx, DVITOMP);
      strcpy(infile, tmpname);
      strcat(infile, ".dvi");
      strcpy(inerror, DVIERR);
      strcpy(mp_log, tmpname);
      strcat(mp_log, ".log");
    } else {
      strcpy(mp_log, tmpname);
      strcat(mp_log, ".log");
      rename(mp_tex, TEXERR);
      rename(mp_log, ERRLOG);
      fprintf(stderr, "%s: Command failed: tex mpxerr.tex; see mpxerr.log\n",
              progname);
      erasetmp();
      uexit (2);
    }
  }
  else if(mpmode == 1) { /* troff mode */

    strcpy(mp_i, tmpname);
    strcat(mp_i, ".i");
    rename(mp_tex, mp_i);

    strcpy(mp_t, tmpname);
    strcat(mp_t, ".t");
	fr = makempx_xfopen(mp_i,"r");

    strcpy(mp_tmp, tmpname);
	strcat(mp_tmp, ".tmp");
	fw = makempx_xfopen(mp_tmp,"wb");

	/* split the command in bits */
	cmdbitlength = split_pipes(maincmd,cmdbits);
	
	for (i=0;i<cmdbitlength;i++) {
	  cmdlength = split_command(cmdbits[i],cmdline);

	  sav_i = DUP(fileno(stdin));
	  sav_o = DUP(fileno(stdout));
	  DUPP(fileno(fr), fileno(stdin));
	  DUPP(fileno(fw), fileno(stdout));
	  
	  retcode = run_command(cmdlength, cmdline);

	  DUPP(sav_i, fileno(stdin));
	  close(sav_i);
	  DUPP(sav_o, fileno(stdout));
	  close(sav_o);
	  fclose(fr); 
	  fclose(fw);
	  if(retcode) {
		rename(mp_i, TROFF_INERR);
		fprintf(stderr, "%s: Command failed: %s\n", progname, (char *)cmdline[0]);
		erasetmp();
		uexit (2);
	  }	
	  if (i % 2) {
		fr = makempx_xfopen(mp_tmp, "r");
		fw = makempx_xfopen(mp_t, "wb");
		strcpy(infile, mp_t);
	  } else {
		fr = makempx_xfopen(mp_t, "r");
		fw = makempx_xfopen(mp_tmp, "wb");
		strcpy(infile, mp_tmp);
	  }
	}
	strcpy(whatever_to_mpx, DMP);
	strcpy(inerror, TROFF_OUTERR);
  }

  /* Step 3: */

  fw = makempx_xfopen(ERRLOG, "wb");

  sav_o = DUP(fileno(stdout));
  DUPP(fileno(fw), fileno(stdout));

  cmdline[0] = whatever_to_mpx;
  cmdline[1] = infile;
  cmdline[2] = mpxfile;
  retcode = run_command(3, cmdline);

  DUPP(sav_o, fileno(stdout));
  close(sav_o); fclose(fw);
  
  if(retcode) {
    rename(infile, inerror);
    if (mpmode == 1) rename(mp_i, TROFF_INERR);
    remove(mpxfile);
    fprintf(stderr, "%s: Command failed: %s %s %s\n",
            progname, whatever_to_mpx, inerror, mpxfile);
    erasetmp();
    uexit(3);
  }
  remove(ERRLOG);
  remove(infile);
  erasetmp();
  uexit (0);
}
