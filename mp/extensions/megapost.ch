% $Id: megapost.ch,v 1.1 2005/04/28 06:45:21 taco Exp $
% megapost changes for 32-bit metapost, by Giuseppe Bilotta.  Public domain.

@x mp.web l.2225
@* \[7] Arithmetic with scaled numbers.
The principal computations performed by \MP\ are done entirely in terms of
integers less than $2^{31}$ in magnitude; thus, the arithmetic specified in this
program can be carried out in exactly the same way on a wide variety of
computers, including some small ones.
@^small computers@>

But \PASCAL\ does not define the @!|div|
operation in the case of negative dividends; for example, the result of
|(-2*n-1) div 2| is |-(n+1)| on some computers and |-n| on others.
There are two principal types of arithmetic: ``translation-preserving,''
in which the identity |(a+q*b)div b=(a div b)+q| is valid; and
``negation-preserving,'' in which |(-a)div b=-(a div b)|. This leads to
two \MP s, which can produce different results, although the differences
should be negligible when the language is being used properly.
The \TeX\ processor has been defined carefully so that both varieties
of arithmetic will produce identical output, but it would be too
inefficient to constrain \MP\ in a similar way.

@d el_gordo == @'17777777777 {$2^{31}-1$, the largest value that \MP\ likes}
@y
@* \[7] Arithmetic with scaled numbers.
The principal computations performed by \MP\ are done entirely in terms of
integers less than $2^{63}$ in magnitude; thus, the arithmetic specified in this
program can be carried out in exactly the same way on a wide variety of
computers, including some small ones.
@^small computers@>

But \PASCAL\ does not define the @!|div|
operation in the case of negative dividends; for example, the result of
|(-2*n-1) div 2| is |-(n+1)| on some computers and |-n| on others.
There are two principal types of arithmetic: ``translation-preserving,''
in which the identity |(a+q*b)div b=(a div b)+q| is valid; and
``negation-preserving,'' in which |(-a)div b=-(a div b)|. This leads to
two \MP s, which can produce different results, although the differences
should be negligible when the language is being used properly.
The \TeX\ processor has been defined carefully so that both varieties
of arithmetic will produce identical output, but it would be too
inefficient to constrain \MP\ in a similar way.

@d el_gordo == @"7FFFFFFFFFFFFFFF {$2^{63}-1$, the largest value that \MP\ likes}
@z

@x mp.web l.2303
@ Fixed-point arithmetic is done on {\sl scaled integers\/} that are multiples
of $2^{-16}$. In other words, a binary point is assumed to be sixteen bit
positions from the right end of a binary computer word.

@d quarter_unit == @'40000 {$2^{14}$, represents 0.250000}
@d half_unit == @'100000 {$2^{15}$, represents 0.50000}
@d three_quarter_unit == @'140000 {$3\cdot2^{14}$, represents 0.75000}
@d unity == @'200000 {$2^{16}$, represents 1.00000}
@d two == @'400000 {$2^{17}$, represents 2.00000}
@d three == @'600000 {$2^{17}+2^{16}$, represents 3.00000}

@<Types...@>=
@!scaled = integer; {this type is used for scaled integers}
@!small_number=0..63; {this type is self-explanatory}
@y
@ Fixed-point arithmetic is done on {\sl scaled integers\/} that are multiples
of $2^{-32}$. In other words, a binary point is assumed to be sixteen bit
positions from the right end of a binary computer word.

@d quarter_unit == @"40000000 {$2^{30}$, represents 0.250000}
@d half_unit == @"80000000 {$2^{31}$, represents 0.50000}
@d three_quarter_unit == @"C00000000 {$3\cdot2^{30}$, represents 0.75000}
@d unity == @"100000000 {$2^{32}$, represents 1.00000}
@d two == @"200000000 {$2^{33}$, represents 2.00000}
@d three == @"300000000 {$2^{33}+2^{32}$, represents 3.00000}

@<Types...@>=
@!scaled = long integer; {this type is used for scaled integers; FIXME}
@!small_number=0..63; {this type is self-explanatory}
@z

@x mp.web l.2347
procedure print_scaled(@!s:scaled); {prints scaled real, rounded to five
  digits}
var @!delta:scaled; {amount of allowable inaccuracy}
begin if s<0 then
  begin print_char("-"); negate(s); {print the sign, if negative}
  end;
print_int(s div unity); {print the integer part}
s:=10*(s mod unity)+5;
if s<>5 then
  begin delta:=10; print_char(".");
  repeat if delta>unity then
    s:=s+@'100000-(delta div 2); {round the final digit}
  print_char("0"+(s div unity)); s:=10*(s mod unity); delta:=delta*10;
  until s<=delta;
  end;
end;
@y
procedure print_scaled(@!s:scaled); {prints scaled real, rounded to five
  digits}
var @!delta:scaled; {amount of allowable inaccuracy}
begin if s<0 then
  begin print_char("-"); negate(s); {print the sign, if negative}
  end;
print_int(s div unity); {print the integer part}
s:=10*(s mod unity)+5;
if s<>5 then
  begin delta:=10; print_char(".");
  repeat if delta>unity then
    s:=s+half_unit-(delta div 2); {round the final digit}
  print_char("0"+(s div unity)); s:=10*(s mod unity); delta:=delta*10;
  until s<=delta;
  end;
end;
@z

@x mp.web l.2318
@ The |scaled| quantities in \MP\ programs are generally supposed to be
less than $2^{12}$ in absolute value, so \MP\ does much of its internal
arithmetic with 28~significant bits of precision. A |fraction| denotes
a scaled integer whose binary point is assumed to be 28 bit positions
from the right.

@d fraction_half==@'1000000000 {$2^{27}$, represents 0.50000000}
@d fraction_one==@'2000000000 {$2^{28}$, represents 1.00000000}
@d fraction_two==@'4000000000 {$2^{29}$, represents 2.00000000}
@d fraction_three==@'6000000000 {$3\cdot2^{28}$, represents 3.00000000}
@d fraction_four==@'10000000000 {$2^{30}$, represents 4.00000000}

@<Types...@>=
@!fraction=integer; {this type is used for scaled fractions}

@ In fact, the two sorts of scaling discussed above aren't quite
sufficient; \MP\ has yet another, used internally to keep track of angles
in units of $2^{-20}$ degrees.

@d forty_five_deg==@'264000000 {$45\cdot2^{20}$, represents $45^\circ$}
@d ninety_deg==@'550000000 {$90\cdot2^{20}$, represents $90^\circ$}
@d one_eighty_deg==@'1320000000 {$180\cdot2^{20}$, represents $180^\circ$}
@d three_sixty_deg==@'2640000000 {$360\cdot2^{20}$, represents $360^\circ$}

@<Types...@>=
@!angle=integer; {this type is used for scaled angles}
@y
@ To recly the code of old \MP, which assumed that the |scaled|
quantities in \MP\ programs are generally supposed to be less than
$2^{12}$ in absolute value, we have |fraction|s which are the same
as a normal scaled. (FIXME in the future we might want to have them
use a higher precision.)

@d fraction_half==half_unit
@d fraction_one==unity
@d fraction_two==two
@d fraction_three==three
@d fraction_four== @"400000000 {$2^{34}$, represents 3.00000}

@<Types...@>=
@!fraction=scaled; {this type is used for scaled fractions}

@ In fact, the two sorts of scaling discussed above aren't quite
sufficient; \MP\ has yet another, used internally to keep track of angles
in units of $2^{-20}$ degrees. (FIXME: does this need adjustement?)

@d forty_five_deg==@'264000000 {$45\cdot2^{20}$, represents $45^\circ$}
@d ninety_deg==@'550000000 {$90\cdot2^{20}$, represents $90^\circ$}
@d one_eighty_deg==@'1320000000 {$180\cdot2^{20}$, represents $180^\circ$}
@d three_sixty_deg==@'2640000000 {$360\cdot2^{20}$, represents $360^\circ$}

@<Types...@>=
@!angle=integer; {this type is used for scaled angles}
@z

@x mp.web l.2590
@p function make_scaled(@!p,@!q:integer):scaled;
var @!f:integer; {the fraction bits, with a leading 1 bit}
@!n:integer; {the integer part of $\vert p/q\vert$}
@!negative:boolean; {should the result be negated?}
@!be_careful:integer; {disables certain compiler optimizations}
begin if p>=0 then negative:=false
else  begin negate(p); negative:=true;
  end;
if q<=0 then
  begin debug if q=0 then confusion("/");@+gubed@;@/
@:this can't happen /}{\quad \./@>
  negate(q); negative:=not negative;
  end;
n:=p div q; p:=p mod q;
if n>=@'100000 then
  begin arith_error:=true;
  if negative then make_scaled:=-el_gordo@+else make_scaled:=el_gordo;
  end
else  begin n:=(n-1)*unity;
  @<Compute $f=\lfloor 2^{16}(1+p/q)+{1\over2}\rfloor$@>;
  if negative then make_scaled:=-(f+n)@+else make_scaled:=f+n;
  end;
end;
@y
@p function make_scaled(@!p,@!q:integer):scaled;
var @!f:integer; {the fraction bits, with a leading 1 bit}
@!n:integer; {the integer part of $\vert p/q\vert$}
@!negative:boolean; {should the result be negated?}
@!be_careful:integer; {disables certain compiler optimizations}
begin if p>=0 then negative:=false
else  begin negate(p); negative:=true;
  end;
if q<=0 then
  begin debug if q=0 then confusion("/");@+gubed@;@/
@:this can't happen /}{\quad \./@>
  negate(q); negative:=not negative;
  end;
n:=p div q; p:=p mod q;
if n>=unity then
  begin arith_error:=true;
  if negative then make_scaled:=-el_gordo@+else make_scaled:=el_gordo;
  end
else  begin n:=(n-1)*unity;
  @<Compute $f=\lfloor 2^{16}(1+p/q)+{1\over2}\rfloor$@>;
  if negative then make_scaled:=-(f+n)@+else make_scaled:=f+n;
  end;
end;
@z

@x mp.web l.2647
@p function velocity(@!st,@!ct,@!sf,@!cf:fraction;@!t:scaled):fraction;
var @!acc,@!num,@!denom:integer; {registers for intermediate calculations}
begin acc:=take_fraction(st-(sf div 16), sf-(st div 16));
acc:=take_fraction(acc,ct-cf);
num:=fraction_two+take_fraction(acc,379625062);
  {$2^{28}\sqrt2\approx379625062.497$}
denom:=fraction_three+take_fraction(ct,497706707)+take_fraction(cf,307599661);
  {$3\cdot2^{27}\cdot(\sqrt5-1)\approx497706706.78$ and
    $3\cdot2^{27}\cdot(3-\sqrt5\,)\approx307599661.22$}
if t<>unity then num:=make_scaled(num,t);
  {|make_scaled(fraction,scaled)=fraction|}
if num div 4>=denom then velocity:=fraction_four
else velocity:=make_fraction(num,denom);
end;
@y
@p function velocity(@!st,@!ct,@!sf,@!cf:fraction;@!t:scaled):fraction;
var @!acc,@!num,@!denom:integer; {registers for intermediate calculations}
begin acc:=take_fraction(st-(sf div 16), sf-(st div 16));
acc:=take_fraction(acc,ct-cf);
num:=fraction_two+take_fraction(acc,6074001000);
  {$2^{32}\sqrt2\approx6074000999.95$}
denom:=fraction_three+take_fraction(ct,7963307308)+take_fraction(cf,4921594580);
  {$3\cdot2^{31}\cdot(\sqrt5-1)\approx7963307308.49$ and
    $3\cdot2^{31}\cdot(3-\sqrt5\,)\approx4921594579.50$}
if t<>unity then num:=make_scaled(num,t);
  {|make_scaled(fraction,scaled)=fraction|}
if num div 4>=denom then velocity:=fraction_four
else velocity:=make_fraction(num,denom);
end;
@z

@x mp.web l.2729
function round_fraction(@!x:fraction):scaled;
  {$\lfloor x/2^{12}+.5\rfloor$}
var @!be_careful:integer; {temporary register}
begin if x>=2048 then round_fraction:=1+((x-2048) div 4096)
else if x>=-2048 then round_fraction:=0
else  begin be_careful:=x+1;
  round_fraction:=-(1+((-be_careful-2048) div 4096));
  end;
end;
@y
function round_fraction(@!x:fraction):scaled;
begin
  round_fraction:=x
end;
@z

  FIXME: check pythagorean ops around l. 2800++

  TODO: logtables etc from around l. 2880 on
