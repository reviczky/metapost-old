# $Id: metapost.mk,v 1.9 2005/03/18 19:49:05 taco Exp $
# Makefile fragment for MetaPost.  Public domain.

metapost = mpost dvitomp

mpware = mpware/dmp mpware/makempx mpware/mpto mpware/newer
mpware_sources = mpware/dmp.c mpware/makempx.in mpware/mpto.c mpware/newer.c

# We put some programs (written directly in C) in a subdirectory.
$(mpware): $(mpware_sources)
	cd mpware && $(MAKE) $(common_makeargs)

# MetaPost
mp_c = mpini.c mp0.c mp1.c mp2.c
mp_o = mpini.o mp0.o mp1.o mp2.o mpextra.o
mpost: $(mp_o)
	$(kpathsea_link) $(mp_o) $(LOADLIBES)
$(mp_c) mpcoerce.h mpd.h: mp.p $(web2c_texmf) web2c/cvtmf1.sed web2c/cvtmf2.sed
	$(web2c) mp
mpextra.c: lib/texmfmp.c
	sed s/TEX-OR-MF-OR-MP/mp/ $(srcdir)/lib/texmfmp.c >$@
mp.p mp.pool: tie tangle mp.web mpbugs.ch nonpsspace.ch hiresbb.ch mp.ch mpversion.ch
	$(tie) -m mp-tied.web mp.web mpbugs.ch hiresbb.ch nonpsspace.ch mpversion.ch
	$(tangle) mp-tied.web mp.ch
	mv -f mp-tied.p mp.p
	mv -f mp-tied.pool mp.pool

check: mpost-check
mpost-check: mptrap mpost.mem $(mpware)
	./mpost --progname=mpost '&./mpost \tracingstats:=1; end.'
	TEXMFCNF=../kpathsea \
	  MAKEMPX_BINDIR=`pwd`:`pwd`/mpware MPXCOMMAND=mpware/makempx \
	  ./mpost --progname=mpost $(srcdir)/tests/mptest
	./mpost --progname=mpost $(srcdir)/tests/one.two
	./mpost --progname=mpost $(srcdir)/tests/uno.dos
clean:: mpost-clean
mpost-clean: mptrap-clean
	$(LIBTOOL) --mode=clean rm -f mpost
	rm -f $(mp_o) $(mp_c) mpextra.c mpcoerce.h mpd.h mp.p mp.pool
	rm -f mpost.mem mpost.log
	rm -f mpout.log mptest.log one.two.log uno.log

dvitomp: dvitomp.o
	$(kpathsea_link) dvitomp.o $(LOADLIBES)
dvitomp.c dvitomp.h: $(web2c_common) $(web2c_programs) dvitomp.p
	$(web2c) dvitomp
dvitomp.p: tie tangle dvitomp.web dvitomp.ch dvitompbugs.ch
	$(tie) -m dvitomp-tied.web dvitomp.web dvitompbugs.ch
	$(tangle) dvitomp-tied.web dvitomp.ch
	mv -f dvitomp-tied.p dvitomp.p

check: dvitomp-check
dvitomp-check: dvitomp
	TEXMFCNF=../kpathsea \
	  ./dvitomp $(srcdir)/tests/story.dvi tests/xstory.mpx
	TFMFONTS=$(srcdir)/tests VFFONTS=$(srcdir)/tests: \
	  ./dvitomp $(srcdir)/tests/ptmr 
	mv ptmr.mpx tests/xptmr.mpx
clean:: dvitomp-clean
dvitomp-clean:
	$(LIBTOOL) --mode=clean rm -f dvitomp
	rm -f dvitomp.o dvitomp.c dvitomp.h dvitomp.p
	rm -f tests/xstory.mpx tests/xptmr.mpx

mp-programs: $(metapost) $(mpware)

# Can't run trap and mptrap in parallel, because both write trap.{log,tfm}.
mptrap: mpost pltotf tftopl mptrap-clean
	@echo ">>> See $(testdir)/mptrap.diffs for example of acceptable diffs." >&2
	$(LN) $(testdir)/mtrap.mp . # get same filename in log
	./pltotf $(testdir)/trapf.pl trapf.tfm
	-$(SHELL) -c '$(testenv) ./mpost --progname=inimpost mtrap'
	-diff $(testdir)/mtrap.log mtrap.log
	-diff $(testdir)/mtrap.0 mtrap.0
	-diff $(testdir)/mtrap.1 mtrap.1
	-diff $(testdir)/writeo writeo
	-diff $(testdir)/writeo.2 writeo.2
	$(LN) $(testdir)/trap.mp .
	$(LN) $(testdir)/trap.mpx .
	-$(SHELL) -c '$(testenv) ./mpost --progname=inimpost <$(testdir)/mptrap1.in >mptrapin.fot'
	mv trap.log mptrapin.log
	-diff $(testdir)/mptrapin.log mptrapin.log
# Must run inimp or font_name[null_font] is not initialized, leading to diffs.
	-$(SHELL) -c '$(testenv) ./mpost --progname=inimpost <$(testdir)/mptrap2.in >mptrap.fot'
	mv trap.log mptrap.log
	mv trap.tfm mptrap.tfm
	-diff $(testdir)/mptrap.fot mptrap.fot
	-diff $(testdir)/mptrap.log mptrap.log
	-diff $(testdir)/trap.5 trap.5
	-diff $(testdir)/trap.6 trap.6
	-diff $(testdir)/trap.148 trap.148
	-diff $(testdir)/trap.149 trap.149
	-diff $(testdir)/trap.150 trap.150
	-diff $(testdir)/trap.151 trap.151
	-diff $(testdir)/trap.197 trap.197
	-diff $(testdir)/trap.200 trap.200
	./tftopl ./mptrap.tfm mptrap.pl
	-diff $(testdir)/mptrap.pl mptrap.pl

mptrap-clean:
	rm -f mtrap.mp mtrap.mem trapf.tfm
	rm -f mtrap.log mtrap.0 mtrap.1 writeo writeo.log writeo.2
	rm -f trap.mp trap.mpx mptrapin.fot mptrapin.log
	rm -f mptrap.fot mptrap.log mptrap.tfm
	rm -f trap.ps trap.mem trap.0 trap.5 trap.6 trap.95 trap.96 trap.97
	rm -f trap.98 trap.99 trap.100 trap.101 trap.102 trap.103 trap.104
	rm -f trap.105 trap.106 trap.107 trap.108 trap.109 trap.148
	rm -f trap.149 trap.150 trap.151 trap.197 trap.200
	rm -f mptrap.pl

all_mems = mpost.mem

mems: $(all_mems)

mpost.mem: mpost
	$(dumpenv) $(MAKE) progname=mpost files=plain.mp prereq-check
	$(dumpenv) ./mpost --progname=mpost --jobname=mpost --ini \\input plain dump </dev/null

$(mppooldir)::
	$(SHELL) $(top_srcdir)/../mkinstalldirs $(mppooldir)

install-mpost: install-mpost-exec install-mpost-data
install-mpost-exec: @FMU@ install-mpost-links
install-mpost-data: install-mpost-pool @FMU@ install-mpost-dumps
install-mpost-dumps: install-mpost-mems

install-programs: install-mpost-programs
install-mpost-programs: mpost $(bindir)
	cd mpware && $(MAKE) $(install_makeargs) install-exec
	mpost="mpost"; \
	  for p in $$mpost; do $(INSTALL_LIBTOOL_PROG) $$p $(bindir); done

install-data:: install-mpost-data

install-dumps: install-mpost-dumps

install-links: install-mpost-links
install-mpost-links: install-mpost-programs

install-mems: install-mpost-mems
install-mpost-mems: mems $(memdir)
	mems="$(all_mems)"; \
	  for f in $$mems; do $(INSTALL_DATA) $$f $(memdir)/$$f; done
	cd $(memdir) && (rm -f plain.mem; $(LN) mpost.mem plain.mem)
	mems="$(mems)"; \
	  for f in $$mems; do base=`basename $$f .mem`; \
            (cd $(bindir) && (rm -f $$base; $(LN) mpost $$base)); done

install-mpost-pool: mp.pool $(mppooldir)
	$(INSTALL_DATA) mp.pool $(mppooldir)/mp.pool
