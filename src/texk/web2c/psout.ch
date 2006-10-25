% $Id$
%
% This file improves the PostScript output when prologues is 2 or 3.
% The actual font inclusion is done in C source files.

@x l. 3985
@d special_command=30 {output special info (\&{special})}
@y
@d special_command=30 {output special info (\&{special}) 
                       or font map info (\&{mapfile}, \&{mapline})}
@z

@x l. 4892
primitive("special",special_command,0);
@!@:special}{\&{special} primitive@>
@y
primitive("special",special_command,0);
@!@:special}{\&{special} primitive@>
primitive("mapfile",special_command,1);
@!@:special}{\&{special} primitive@>
primitive("mapline",special_command,2);
@!@:special}{\&{special} primitive@>
@z

@x l. 4947
special_command: print("special");
@y
special_command: if m=2 then print("mapline") else 
                 if m=1 then print("mapfile") else 
                 print("special");
@z

@x l. 20981
font_info:array[0..font_mem_size] of memory_word;
  {height, width, and depth data}
@y
font_info:array[0..font_mem_size] of memory_word;
  {height, width, and depth data}
@!font_used:array[font_number] of boolean;
  {has any character from this font actually appeared in the output?}
@!mp_font_map: ^fm_entry_ptr; {pointer into AVL tree of font mappings}
@z

@x l. 21297
@ The file |ps_tab_file| gives a table of \TeX\ font names and corresponding
PostScript names for fonts that do not have to be downloaded, i.e., fonts that
@y
@ The new primitives mapfile and mapline.

@<Declare action procedures for use by |do_statement|@>=
procedure do_mapfile;
begin get_x_next; scan_expression;
if cur_type<>string_type then @<Complain about improper map operation@>
else mpmapfile(cur_exp);
end;
procedure do_mapline;
begin get_x_next; scan_expression;
if cur_type<>string_type then @<Complain about improper map operation@>
else begin mpmapline(cur_exp);
  end;
end;

@ @<Complain about improper map operation@>=
begin exp_err("Unsuitable expression");
help1("Only known strings can be map files or map lines.");
put_get_error;
end

@ the C code needs to know how to get at the null font, how remove
a string from memory, etc.

@d is_valid_char(#)==((font_bc[f] <= #) and (# <= font_ec[f]) and
                      ichar_exists(char_info(f)(#)))


@p function get_nullfont: font_number;
begin
    get_nullfont := null_font;
end;
@#
procedure flush_str(s: str_number); {flush a string if possible}
begin
    flush_string(s);
end;
@#
function get_nullstr: str_number;
begin
    get_nullstr := "";
end;
@#
function get_charwidth(f: font_number; c: eight_bits): scaled;
begin
    if is_valid_char(c) then
        get_charwidth := char_width(f)(char_info(f)(c))
    else
        get_charwidth := 0;
end;

@ 
@<Declare the \ps\ output procedures@>=
function mp_char_marked(@!f:font_number;@!c: eight_bits): boolean;
var @!b:integer; {|char_base[f]|}
begin b:=char_base[f];
if (c>=font_bc[f])and(c<=font_ec[f])and(font_info[b+c].qqqq.b3<>0) then
  mp_char_marked:=true
else
  mp_char_marked:=false;
end;

@ The fontmap entries need a typedef

@<Types...@>=
fm_entry_ptr = ^integer;

@ To print |scaled| value to PDF output we need some subroutines to ensure
accurary.

@d max_integer == @"7FFFFFFF {$2^{31}-1$}
@d call_func(#) == begin if # <> 0 then do_nothing end

@<Glob...@>=
@!one_bp: scaled; {scaled value corresponds to 1bp}
@!one_hundred_bp: scaled; {scaled value corresponds to 100bp}
@!one_hundred_inch: scaled; {scaled value corresponds to 100in}
@!ten_pow: array[0..9] of integer; {$10^0..10^9$}
@!scaled_out: integer; {amount of |scaled| that was taken out in
|divide_scaled|}

@ @<Set init...@>=
one_bp := 65782; {65781.76}
one_hundred_bp := 6578176;
one_hundred_inch := 473628672;
ten_pow[0] := 1;
for i := 1 to 9 do
    ten_pow[i] := 10*ten_pow[i - 1];


@ The following function divides |s| by |m|. |dd| is number of decimal digits.

@p function divide_scaled(s, m: scaled; dd: integer): scaled;
var q, r: scaled;
    sign, i: integer;
begin
    sign := 1;
    if s < 0 then begin
        sign := -sign;
        s := -s;
    end;
    if m < 0 then begin
        sign := -sign;
        m := -m;
    end;
    if m = 0 then
       confusion("arithmetic: divided by zero")
    else if m >= (max_integer div 10) then
        confusion("arithmetic: number too big");
    q := s div m;
    r := s mod m;
    for i := 1 to dd do begin
        q := 10*q + (10*r) div m;
        r := (10*r) mod m;
    end;
    if 2*r >= m then begin
        incr(q);
        r := r - m;
    end;
    scaled_out := sign*(s - (r div ten_pow[dd]));
    divide_scaled := sign*q;
end;

@ The file |ps_tab_file| gives a table of \TeX\ font names and corresponding
PostScript names for fonts that do not have to be downloaded, i.e., fonts that
@z

@x l. 22825
special_command:do_special;
@y
special_command: if cur_mod=0 then do_special else if cur_mod=1 then do_mapfile else do_mapline;
@z

@x l. 22965
@<Get the first line of input and prepare to start@>;
@y
@<Get the first line of input and prepare to start@>;
mp_init_map_file('mpost.map');
@z
