/* $Id$
makempx.c
Translated from sh script to C by A. K. ( Aug. 1997 )
Changed : 2001/08 --ak
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
 #define _dup dup
 #define _dup2 dup2
#endif
#include <string.h>
#include <ctype.h>

#include <kpathsea/kpathsea.h>

#define DMP "dmp"
#define DVITOMP "dvitomp"
#define DEFMPTEXPRE "mptexpre.tex"
#define NEWER "newer"
#define TEX "tex"
#define ERRLOG "mpxerr.log"
#define TEXERR "mpxerr.tex"
#define DVIERR "mpxerr.dvi"
#define TROFF_INERR "mpxerr"
#define TROFF_OUTERR "mpxerr.t"
#define MPTO "mpto"

/* TeX command name */
char texcmd[32];

char *progname;

void usage(void)
{
  fprintf(stderr, "Usage: %s [-tex[=TEXCOMMAND]|-troff] MPFILE MPXFILE.\n",
          progname);
  fprintf(stderr, "If MPXFILE is older than MPFILE, translate ");
  fprintf(stderr, "the labels from the MetaPost\n");
  fprintf(stderr, "input file MPFILE to low-level commands ");
  fprintf(stderr, "in MPXFILE, by running\n");
  fprintf(stderr, "mpto -tex, tex, and dvitomp\n");
  fprintf(stderr, "by default; if -troff is specified,\n");
  fprintf(stderr, "mpto -troff, geqn -d$$ | gtroff -Tps, ");
  fprintf(stderr, "and dmp.\n");
  fprintf(stderr, "\nThe current directory is used for writing ");
  fprintf(stderr, "temporary files. Errors are\n");
  fprintf(stderr, "left in mpxerr.{tex, log, dvi}.\n");
  fprintf(stderr, "\nIf the file named in $MPTEXPRE ");
  fprintf(stderr, "(mptexpre.tex by default) exists, ");
  fprintf(stderr, "it is\nprepended to the output in tex mode.\n");
  fprintf(stderr, "\nEmail bug reports to tex-k@mail.tug.org.\n");
  exit (0);
}

void mess(void)
{
  fprintf(stderr, "Try %s --help for more information.\n", progname);
  exit (1);
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

#ifndef WIN32
int do_spawn (const char *a,const char *b,const char *c,const char *d,const char *e,const char *f,const char *g) {
  pid_t child;
  int retcode;
  
  child = fork();
  if (child>=0) {
	if (child==0) {
	  execlp(a,b,c,d,e,f,g, NULL);
	} else
	  wait(&retcode);
  }
  return retcode;
}
#endif

int main(int ac, char **av)
{
  int mpmode = 0;
  /*
      mpmode = 0 for tex
      mpmode = 1 for troff
  */
  char tmptemplate[] = "mpXXXXXX";
#ifdef WIN32
    char nuldev[] = "nul";
#else
    char nuldev[] = "/dev/null";
#endif
  
  char buffer[MBUF];
  char mpfile[LNAM], mpxfile[LNAM], mptexpre[LNAM];
  char mpto_opt[SNAM], cmd[SNAM], whatever_to_mpx[SNAM];
  char infile[SNAM], inerror[SNAM];

  char *tmpname = NULL, *env = NULL;

  int retcode, i, sav_o, sav_e, sav_i;

  FILE *fr, *fw, *few, *fnulr, *fnulw;

#ifdef WIN32
  getlongname(av[0]);
#endif
  progname = av[0];

/* Initialize buffer for temparary file names */
  for(i = 0; i < SNAM; i++) {
    mp_tex[i] = '\0';
    mp_i[i] = '\0';
    mp_t[i] = '\0';
    mp_tmp[i] = '\0';
    mp_log[i] = '\0';
  }

  kpse_set_progname(progname);

  if((ac != 2) && (ac != 3) && (ac != 4)) {
    fprintf(stderr, "%s: Invalid command line.\n", progname);
    mess();
  }

/* Set TeX command */
  if((env = kpse_var_value("TEX")))
    strcpy(texcmd, env);
  else if((env = kpse_var_value("MPXTEXCMD")))
    strcpy(texcmd, env);
  else
    strcpy(texcmd, TEX);

  if(env) free(env);

  if(ac == 3) {
    if(strchr(av[1], ' ') && (av[1][0] != '\"')) {
      strcpy(mpfile, "\"");
      strcat(mpfile, av[1]);
      strcat(mpfile, "\"");
    } else strcpy(mpfile, av[1]);
    if(strchr(av[2], ' ') && (av[2][0] != '\"')) {
      strcpy(mpxfile, "\"");
      strcat(mpxfile, av[2]);
      strcat(mpxfile, "\"");
    } else strcpy(mpxfile, av[2]);
  }

  if(ac == 4 || ac == 2) {
    if(av[1][0] != '-') {
      fprintf(stderr, "%s: Invalid command line.\n", progname);
      mess();
    }
    if((ac ==2) && (!strncmp(av[1], "-help", 5) ||
       !strncmp(av[1], "--help", 6))) {
      usage();
    }
    else if((ac == 2) && (!strncmp(av[1], "-version", 8) ||
            !strncmp(av[1], "--version", 9))) {
      fprintf(stderr, "%s: (Web2c 7.3.8) 1.8\n", progname);
      fprintf(stderr, "There is NO warranty.\n");
      fprintf(stderr, "Primary author: John Hobby; ");
      fprintf(stderr, "Web2c maintainer: O. Weber.\n");
      fprintf(stderr, "Win32 C version 1.1: A. K.\n");
      exit (0);
    }
    else if((ac == 4) && (!strncmp(av[1], "-troff", 6) ||
            !strncmp(av[1], "--troff", 7))) {
      mpmode = 1;
    }
    else if((ac == 4) && (!strncmp(av[1], "-tex", 4) ||
            !strncmp(av[1], "--tex", 5))) {
      mpmode = 0;
      if(!strncmp(av[1], "-tex=", 5)) strcpy(texcmd, av[1] + 5);
      else if(!strncmp(av[1], "--tex=", 6)) strcpy(texcmd, av[1] + 6);
    }
    else {
      fprintf(stderr, "%s: Invalid option: %s.\n", progname, av[1]);
      mess();
    }
    if(ac == 4) {
      if(strchr(av[2], ' ') && (av[2][0] != '\"')) {
        strcpy(mpfile, "\"");
        strcat(mpfile, av[2]);
        strcat(mpfile, "\"");
      } else strcpy(mpfile, av[2]);
      if(strchr(av[3], ' ') && (av[3][0] != '\"')) {
        strcpy(mpxfile, "\"");
        strcat(mpxfile, av[3]);
        strcat(mpxfile, "\"");
      } else strcpy(mpxfile, av[3]);
    }
    else {
      mess();
    }
  }

/* Check if mpfile is newer than mpxfile */
#ifdef WIN32
  retcode = spawnlp(P_WAIT, NEWER, NEWER, mpfile, mpxfile, NULL);
#else
  retcode = do_spawn(NEWER, NEWER, mpfile, mpxfile, NULL, NULL, NULL);
#endif

/* If MPX file is up-to-date or if MP file does not exist, do nothing. */
  if(retcode) exit (0);

  if(mpmode == 0) strcpy(mpto_opt, "-tex");
  else if(mpmode == 1) strcpy(mpto_opt, "-troff");

  tmpname = (char *)mktemp(tmptemplate);

  strcpy(mp_tex, tmpname);
  strcat(mp_tex, ".tex");

/* step 1: */

  if(!(fw = fopen(mp_tex, "wb"))) {
    fprintf(stderr, "Unable to open %s\n", mp_tex);
    erasetmp();
    exit(1);
  }
  if(!(few = fopen(ERRLOG, "wb"))) {
    fprintf(stderr, "Unable to open ERRLOG\n");
    erasetmp();
    exit(1);
  }

  sav_o = _dup(fileno(stdout));
  sav_e = _dup(fileno(stderr));

  _dup2(fileno(fw), fileno(stdout));
  _dup2(fileno(few), fileno(stderr));

#ifdef WIN32
  retcode = spawnlp(P_WAIT, MPTO, MPTO, mpto_opt, mpfile, NULL);
#else
  retcode = do_spawn(MPTO, MPTO, mpto_opt, mpfile, NULL, NULL, NULL);
#endif
  
  _dup2(sav_o, fileno(stdout));
  close(sav_o);
  _dup2(sav_e, fileno(stderr));
  close(sav_e);
  fclose(fw); fclose(few);

  if(retcode) {
    fprintf(stderr, "%s: Command failed: mpto %s %s\n",
            progname, mpto_opt, mpfile);
    erasetmp();
    exit (1);
  }

  if(mpmode == 1) {
    strcpy(mp_i, tmpname);
    strcat(mp_i, ".i");
    rename(mp_tex, mp_i);
  }

/* step 2: */

  if(mpmode == 0) {   /* TeX mode */
    if((env = getenv("MPTEXPRE"))) strcpy(mptexpre, env);
    else if((env = kpse_var_value("MPTEXPRE"))) strcpy(mptexpre, env);
    else strcpy(mptexpre, "mptexpre.tex");

    if(!access(mptexpre, 4)) {
      strcpy(mp_tmp, tmpname);
      strcat(mp_tmp, ".tmp");
      if(!(fr = fopen(mptexpre, "r"))) {
        fprintf(stderr, "Cannot open %s.\n", mptexpre);
        erasetmp();
        exit (1);
      }
      if(!(fw = fopen(mp_tmp, "wb"))) {
        fprintf(stderr, "Cannot open %s.\n", mp_tmp);
        erasetmp();
        exit (1);
      }
      
      while((i = fread(buffer, 1, MBUF, fr)))
        fwrite(buffer, 1, i, fw);
      fclose(fr);
      if(!(fr = fopen(mp_tex, "r"))) {
        fprintf(stderr, "Cannot open %s.\n", mp_tex);
        erasetmp();
        exit (1);
      }
      while((i = fread(buffer, 1, MBUF, fr)))
        fwrite(buffer, 1, i, fw);

      fclose(fr); fclose(fw);

      remove(mp_tex); rename(mp_tmp, mp_tex);
    }
    
#ifdef WIN32
    strcpy(cmd, "--parse-first-line --interaction=nonstopmode ");
#endif
    strcat(cmd, mp_tex);

    if(!(fnulr = fopen(nuldev, "r"))) {
      fprintf(stderr, "Cannot open nul device to read.\n");
      erasetmp();
      exit (1);
    }
    if(!(fnulw = fopen(nuldev, "w"))) {
      fprintf(stderr, "Cannot open nul device to write.\n");
      erasetmp();
      exit (1);
    }
    sav_i = _dup(fileno(stdin));
    sav_o = _dup(fileno(stdout));
    _dup2(fileno(fnulr), fileno(stdin));
    _dup2(fileno(fnulw), fileno(stdout));

#ifdef WIN32
    retcode = spawnlp(P_WAIT, texcmd, texcmd, cmd, NULL);
#else
	retcode = do_spawn(texcmd, texcmd, "--parse-first-line", "--interaction=nonstopmode", cmd, NULL, NULL);
#endif

    _dup2(sav_i, fileno(stdin));
    close(sav_i);
    _dup2(sav_o, fileno(stdout));
    close(sav_o);
    fclose(fnulr); fclose(fnulw);

    if(!retcode) {
      strcpy(whatever_to_mpx, DVITOMP);
      strcpy(infile, tmpname);
      strcat(infile, ".dvi");
      strcpy(inerror, DVIERR);
      strcpy(mp_log, tmpname);
      strcat(mp_log, ".log");
    }
    else {
      strcpy(mp_log, tmpname);
      strcat(mp_log, ".log");
      rename(mp_tex, TEXERR);
      rename(mp_log, ERRLOG);
      fprintf(stderr, "%s: Command failed: tex mpxerr.tex; see mpxerr.log\n",
              progname);
      erasetmp();
      exit (2);
    }
  }
  else if(mpmode == 1) { /* troff mode */
    strcpy(mp_t, tmpname);
    strcat(mp_t, ".t");
    if(!(fr = fopen(mp_i, "r"))) {
      fprintf(stderr, "Cannot open %s to read.\n", mp_i);
      erasetmp();
      exit (1);
    }
    strcpy(mp_tmp, tmpname); strcat(mp_tmp, ".tmp");
    if(!(fw = fopen(mp_tmp, "wb"))) {
      fprintf(stderr, "Cannot open %s to write.\n", mp_tmp);
      erasetmp();
      exit (1);
    }

    sav_i = _dup(fileno(stdin));
    sav_o = _dup(fileno(stdout));
    _dup2(fileno(fr), fileno(stdin));
    _dup2(fileno(fw), fileno(stdout));

#ifdef WIN32
    retcode = spawnlp(P_WAIT, "geqn", "geqn", "-d$$", NULL);
#else
	retcode = do_spawn("geqn", "geqn", "-d$$", NULL, NULL, NULL, NULL);
#endif

    _dup2(sav_i, fileno(stdin));
    close(sav_i);
    _dup2(sav_o, fileno(stdout));
    close(sav_o);
    fclose(fr); fclose(fw);

    if(retcode) {
      rename(mp_i, TROFF_INERR);
      fprintf(stderr, "%s: Command failed: geqn -d$$\n", progname);
      erasetmp();
      exit (2);
    }

    if(!(fr = fopen(mp_tmp, "r"))) {
      fprintf(stderr, "Cannot open %s to read.\n", mp_tmp);
      erasetmp();
      exit (1);
    }
    if(!(fw = fopen(mp_t, "wb"))) {
      fprintf(stderr, "Cannot open %s to write.\n", mp_t);
      erasetmp();
      exit (1);
    }
    sav_i = _dup(fileno(stdin));
    sav_o = _dup(fileno(stdout));
    _dup2(fileno(fr), fileno(stdin));
    _dup2(fileno(fw), fileno(stdout));

#ifdef WIN32
    retcode = spawnlp(P_WAIT, "gtroff", "gtroff", "-Tps", NULL);
#else
	retcode = do_spawn("gtroff", "gtroff", "-Tps", NULL, NULL, NULL, NULL);
#endif

    _dup2(sav_i, fileno(stdin));
    close(sav_i);
    _dup2(sav_o, fileno(stdout));
    close(sav_o);
    fclose(fr); fclose(fw);

    if(retcode) {
      rename(mp_i, TROFF_INERR);
      fprintf(stderr, "%s: Command failed: gtroff -Tps\n", progname);
      erasetmp();
      exit (2);
    }
    else {
      strcpy(whatever_to_mpx, DMP);
      strcpy(infile, mp_t);
      strcpy(inerror, TROFF_OUTERR);
    }
  }

/* Step 3: */

  if(!(fw = fopen(ERRLOG, "wb"))) {
    fprintf(stderr, "Cannot open mpxerr.log to write.\n");
    erasetmp();
    exit (1);
  }
  sav_o = _dup(fileno(stdout));
  _dup2(fileno(fw), fileno(stdout));
#ifdef WIN32
  retcode = spawnlp(P_WAIT, whatever_to_mpx, whatever_to_mpx,
                    infile, mpxfile, NULL);
#else
  retcode = do_spawn(whatever_to_mpx, whatever_to_mpx,
					 infile, mpxfile, NULL, NULL, NULL);
#endif
  _dup2(sav_o, fileno(stdout));
  close(sav_o); fclose(fw);
  
  if(retcode) {
    rename(infile, inerror);
    if(mpmode == 1) rename(mp_i, TROFF_INERR);
    remove(mpxfile);
    fprintf(stderr, "%s: Command failed: %s %s %s\n",
            progname, whatever_to_mpx, inerror, mpxfile);
    erasetmp();
    exit(3);
  }
  remove(ERRLOG);
  remove(infile);
  erasetmp();
  exit (0);
}
