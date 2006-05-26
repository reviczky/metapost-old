#!/usr/bin/perl

use strict;

my $cvsdir     = "/home/taco/metapost/svn";
my $releasedir = "/home/taco/metapost/release";

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday) = gmtime(time());

my $timestamp = $year+1900 . sprintf("/%02d/%02d",($mon+1),$mday);
my $version = '';
my $minorversion = '';
my $currentpackage = '';
# the existance of a separate version in  mpversion.ch indicates that
# we are building a beta version.
if ($version = `grep metapost_version== $cvsdir/mp/mpversion.ch`) {
  $version =~ s/^.+\n\@/\@/g;
  $version =~ s/^.*?=="\s*(.*)"$/$1/;
} else {
  $version = `grep metapost_version== $cvsdir/mp/mp.web`;
  $version =~ s/^.*?=="\s*(.*)"$/$1/;
}
chomp $version;
$currentpackage = "metapost-$version";


die "done already" if (-f "$releasedir/$currentpackage");

# clean up subdirs
chdir("$cvsdir/mpware");
system ("make clean");
chdir("$cvsdir/doc");
#system ("make clean");

chdir ($releasedir);

system "cp -a stripped $currentpackage";

chdir ("$currentpackage");
system "cp -f $cvsdir/README $cvsdir/CHANGES $cvsdir/INSTALL $cvsdir/distro/Build $cvsdir/distro/metapost.xml .";

my $xml = `cat metapost.xml`;
$xml =~ s/#thedate#/$timestamp/g;
$xml =~ s/#theversion#/$version$minorversion/g;
open (OUT,">metapost.xml");
print OUT $xml;
close OUT;

# the needed stuff for building
system "cp -f $cvsdir/metapost.mk $cvsdir/dvitomp.mk $cvsdir/Makefile.in src/texk/web2c";

# this file defines the banner for 'mpost --version'
system "cp -f $cvsdir/texmfmp.c src/texk/web2c/lib";

#docs
mkdir ("manual");
system "cp -f $cvsdir/doc/* manual";

#mplib
mkdir ("texmf");
mkdir ("texmf/metapost");
mkdir ("texmf/metapost/base");
system "cp -rf $cvsdir/mplib/*.mp texmf/metapost/base";
mkdir ("troff");
system "cp -rf $cvsdir/mplib/tr* troff";
mkdir ("troff/charlib");
system "cp -rf $cvsdir/mplib/charlib/* troff/charlib";

chdir ("src");

#mpware
system "rm -rf texk/web2c/mpware";
mkdir "texk/web2c/mpware";
system "cp -f $cvsdir/mpware/* texk/web2c/mpware";

#mp itself
system "cp -f $cvsdir/mp/*.ch $cvsdir/mp/*.web texk/web2c";
system "rm -rf texk/web2c/trapdir";
system "cp -rf $cvsdir/mp/trapdir texk/web2c";

chdir ($releasedir);
system ("tar cjvf $currentpackage.tar.bz2 $currentpackage");

