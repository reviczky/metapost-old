% $Id$
%
% This file improves the PostScript output when prologues is 2 or 3.
% The actual font inclusion is done in C source files.

@x l. 406
@d found2=42 {like |found|, when there's more than two per routine}
@y
@d found2=42 {like |found|, when there's more than two per routine}
@d found3=43 {like |found|, when there's more than three per routine}
@z

@x l. 3985
@d special_command=30 {output special info (\&{special})}
@y
@d special_command=30 {output special info (\&{special}) 
                       or font map info (\&{fontmapfile}, \&{fontmapline})}
@z

@x l. 4397
@d restore_clip_color=35
@d max_given_internal=35
@y
@d restore_clip_color=35
@d mpprocset=36 {wether or not create PostScript command shortcuts}
@d max_given_internal=36
@z

@x l. 4480
primitive("truecorners",internal_quantity,true_corners);@/
@!@:true_corners_}{\&{truecorners} primitive@>
@y
primitive("truecorners",internal_quantity,true_corners);@/
@!@:true_corners_}{\&{truecorners} primitive@>
primitive("mpprocset",internal_quantity,mpprocset);@/
@!@:mpprocset_}{\&{mpprocset} primitive@>
@z

@x l. 4521
int_name[default_color_model]:="defaultcolormodel";
@y
int_name[default_color_model]:="defaultcolormodel";
int_name[mpprocset]:="mpprocset";
@z

@x l. 4892
primitive("special",special_command,0);
@!@:special}{\&{special} primitive@>
@y
primitive("special",special_command,0);
@!@:special}{\&{special} primitive@>
primitive("fontmapfile",special_command,1);
@!@:fontmapfile}{\&{fontmapfile} primitive@>
primitive("fontmapline",special_command,2);
@!@:fontmapline}{\&{fontmapline} primitive@>
@z

@x l. 4947
special_command: print("special");
@y
special_command: if m=2 then print("fontmapline") else 
                 if m=1 then print("fontmapfile") else 
                 print("special");
@z

@x l. 20981
font_info:array[0..font_mem_size] of memory_word;
  {height, width, and depth data}
@y
font_info:array[0..font_mem_size] of memory_word;
  {height, width, and depth data}
@!font_enc_name:array[font_number] of boolean;
  {encoding names, if any}
@!mp_font_map: ^fm_entry_ptr; {pointer into AVL tree of font mappings}
@z

@x l. 21297
@ The file |ps_tab_file| gives a table of \TeX\ font names and corresponding
PostScript names for fonts that do not have to be downloaded, i.e., fonts that
@y
@ The new primitives fontmapfile and fontmapline.

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
function get_termandlogid: integer;
begin
  get_termandlogid:=term_and_log;
end;
@#
function get_charwidth(f: font_number; c: eight_bits): scaled;
begin
    if is_valid_char(c) then
        get_charwidth := char_width(f)(char_info(f)(c))
    else
        get_charwidth := 0;
end;
@#
function tfm_lookup(s: str_number; fs: scaled): font_number;
{looks up for a TFM with name |s| loaded at |fs| size; if found then flushes |s|}
var k: font_number;
begin
    if fs <> 0 then begin { should not be used! }
        for k := null_font + 1 to last_fnum do
            if str_vs_str(font_name[k], s) and (font_sizes[k] = fs) then begin
                flush_str(s);
                tfm_lookup := k;
                return;
            end;
    end
    else begin
        for k := null_font + 1 to last_fnum do
            if str_vs_str(font_name[k], s) then begin
                flush_str(s);
                tfm_lookup := k;
                return;
            end;
    end;
    tfm_lookup := null_font;
  exit:
end;
@#
function new_dummy_font: font_number;
begin
    new_dummy_font := read_font_info("dummy");
end;

@x
function round_xn_over_d(@!x:scaled; @!n,@!d:integer):scaled;
var positive:boolean; {was |x>=0|?}
@!t,@!u,@!v:nonnegative_integer; {intermediate quantities}
begin if x>=0 then positive:=true
else  begin negate(x); positive:=false;
  end;
t:=(x mod @'100000)*n;
u:=(x div @'100000)*n+(t div @'100000);
v:=(u mod d)*@'100000 + (t mod @'100000);
if u div d>=@'100000 then arith_error:=true
else u:=@'100000*(u div d) + (v div d);
v := v mod d;
if 2*v >= d then
    incr(u);
if positive then
    round_xn_over_d := u
else
    round_xn_over_d := -u;
end;


@ 
@<Declare the \ps\ output procedures@>=
procedure ps_print_cmd(@!l:str_number;@!s:str_number);
begin
if internal[mpprocset]>0 then begin ps_room(length(s)); print(s); end
else begin ps_room(length(l)); print(l); end;
end;
@#
procedure print_cmd(@!l:str_number;@!s:str_number);
begin
if internal[mpprocset]>0 then print(s) else print(l);
end;
@#
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
@!nonnegative_integer=0..@'17777777777; {$0\L x<2^{31}$}

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
mp_font_map:=xmalloc_array(fm_entry_ptr,font_max);
for i := null_font to font_max do begin
  font_enc_name[i] := 0;
  mp_font_map[i] := 0;
  end;
	


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

@x l. 21501
procedure ps_path_out(@!h:pointer);
label exit;
var @!p,@!q:pointer; {for scanning the path}
@!d:scaled; {a temporary value}
@!curved:boolean; {|true| unless the cubic is almost straight}
begin ps_room(40);
if need_newpath then print("newpath ");
need_newpath:=true;
ps_pair_out(x_coord(h),y_coord(h));
print("moveto");@/
p:=h;
repeat if right_type(p)=endpoint then
  begin if p=h then ps_print(" 0 0 rlineto");
  return;
  end;
q:=link(p);
@<Start a new line and print the \ps\ commands for the curve from
  |p| to~|q|@>;
p:=q;
until p=h;
ps_print(" closepath");
exit:end;
@y
procedure ps_path_out(@!h:pointer);
label exit;
var @!p,@!q:pointer; {for scanning the path}
@!d:scaled; {a temporary value}
@!curved:boolean; {|true| unless the cubic is almost straight}
begin ps_room(40);
if need_newpath then print_cmd("newpath ","n ");
need_newpath:=true;
ps_pair_out(x_coord(h),y_coord(h));
print_cmd("moveto","m");@/
p:=h;
repeat if right_type(p)=endpoint then
  begin if p=h then ps_print_cmd(" 0 0 rlineto"," 0 0 r");
  return;
  end;
q:=link(p);
@<Start a new line and print the \ps\ commands for the curve from
  |p| to~|q|@>;
p:=q;
until p=h;
ps_print_cmd(" closepath"," p");
exit:end;
@z

@x l. 21529
@ @<Start a new line and print the \ps\ commands for the curve from...@>=
curved:=true;
@<Set |curved:=false| if the cubic from |p| to |q| is almost straight@>;
print_ln;
if curved then
  begin ps_pair_out(right_x(p),right_y(p));
  ps_pair_out(left_x(q),left_y(q));
  ps_pair_out(x_coord(q),y_coord(q));
  ps_print("curveto");
  end
else if q<>h then
  begin ps_pair_out(x_coord(q),y_coord(q));
  ps_print("lineto");
  end
@y
@ @<Start a new line and print the \ps\ commands for the curve from...@>=
curved:=true;
@<Set |curved:=false| if the cubic from |p| to |q| is almost straight@>;
print_ln;
if curved then
  begin ps_pair_out(right_x(p),right_y(p));
  ps_pair_out(left_x(q),left_y(q));
  ps_pair_out(x_coord(q),y_coord(q));
  ps_print_cmd("curveto","c");
  end
else if q<>h then
  begin ps_pair_out(x_coord(q),y_coord(q));
  ps_print_cmd("lineto","l");
  end
@z

@x l. 21699
if (ww<>gs_width) or (adj_wx<>gs_adj_wx) then
  begin if adj_wx then
    begin ps_room(13);
    print_char(" "); print_scaled(ww);
    ps_print(" 0 dtransform exch truncate exch idtransform pop setlinewidth");
    end
  else begin ps_room(15);
    print(" 0 "); print_scaled(ww);
    ps_print(" dtransform truncate idtransform setlinewidth pop");
    end;
  gs_width := ww;
  gs_adj_wx := adj_wx;
  end
@y
if (ww<>gs_width) or (adj_wx<>gs_adj_wx) then
  begin if adj_wx then
    begin ps_room(13);
    print_char(" "); print_scaled(ww);
    ps_print_cmd(" 0 dtransform exch truncate exch idtransform pop setlinewidth"," hlw");
    end
  else begin 
    if internal[mpprocset]>0 then begin
       ps_room(13);
       print_char(" "); 
       print_scaled(ww);
       ps_print(" vlw");
      end
    else begin ps_room(15);
      print(" 0 "); print_scaled(ww);
      ps_print(" dtransform truncate idtransform setlinewidth pop");
      end;
    end;
  gs_width := ww;
  gs_adj_wx := adj_wx;
  end
@z

@x l. 22238
special_command:do_special;
@y
special_command: if cur_mod=0 then do_special else if cur_mod=1 then do_mapfile else do_mapline;
@z


@x l. 22273
procedure ship_out(@!h:pointer); {output edge structure |h|}
label done,found;
var @!p:pointer; {the current graphical object}
@!q:pointer; {something that |p| points to}
@!t:integer; {a temporary value}
@!f,ff:font_number; {fonts used in a text node or as loop counters}
@!ldf:font_number; {the last \.{DocumentFont} listed (otherwise |null_font|)}
@!done_fonts:boolean; {have we finished listing the fonts in the header?}
@!next_size:quarterword; {the size index for fonts being listed}
@!cur_fsize:array[font_number] of pointer; {current positions in |font_sizes|}
@!ds,@!scf:scaled; {design size and scale factor for a text node}
@!transformed:boolean; {is the coordinate system being transformed?}
begin open_output_file;
if (internal[prologues]>0) and (last_ps_fnum<last_fnum) then
  read_psname_table;
non_ps_setting:=selector; selector:=ps_file_only;@/
@<Print the initial comment and give the bounding box for edge structure~|h|@>;
print("%%BeginProlog"); print_ln;
if internal[prologues]>0 then @<Print the prologue@>;
print("%%EndProlog");
print_nl("%%Page: 1 1"); print_ln;
@<Print any pending specials@>;
unknown_graphics_state(0);
need_newpath:=true;
p:=link(dummy_loc(h));
while p<>null do
  begin if has_color(p) then
    if (pre_script(p))<>null then begin
      print_nl (pre_script(p)); print_ln;
      end;
  fix_graphics_state(p);
  case type(p) of
  @<Cases for translating graphical object~|p| into \ps@>@;
  start_bounds_code,stop_bounds_code: do_nothing;
  end; {all cases are enumerated}
  p:=link(p);
  end;
print("showpage"); print_ln;
print("%%EOF"); print_ln;
a_close(ps_file);
selector:=non_ps_setting;
if internal[prologues]<=0 then clear_sizes;
@<End progress report@>;
if internal[tracing_output]>0 then print_edges(h," (just shipped out)",true);
end;
@y
procedure ship_out(@!h:pointer); {output edge structure |h|}
label done,found,found2,found3;
var @!p:pointer; {the current graphical object}
@!q:pointer; {something that |p| points to}
@!t:integer; {a temporary value}
@!f,ff:font_number; {fonts used in a text node or as loop counters}
@!ldf:font_number; {the last \.{DocumentFont} listed (otherwise |null_font|)}
@!done_fonts:boolean; {have we finished listing the fonts in the header?}
@!next_size:quarterword; {the size index for fonts being listed}
@!cur_fsize:array[font_number] of pointer; {current positions in |font_sizes|}
@!ds,@!scf:scaled; {design size and scale factor for a text node}
@!transformed:boolean; {is the coordinate system being transformed?}
begin open_output_file;
non_ps_setting:=selector; selector:=ps_file_only;@/
if (internal[prologues]=two)or(internal[prologues]=three) then begin
  @<Print improved initial comment and bounding box for edge structure~|h|@>;
  @<Scan all the text nodes and mark the used characters@>;
  mploadencodings(last_fnum);
  @<Update encoding names@>;
  @<Print the improved prologue and setup@>; 
  @<Print any pending specials@>;
  unknown_graphics_state(0);
  need_newpath:=true;
  p:=link(dummy_loc(h));
  while p<>null do
    begin if has_color(p) then
    if (pre_script(p))<>null then begin
      print_nl (pre_script(p)); print_ln;
      end;
    fix_graphics_state(p);
    case type(p) of
    @<Cases for translating graphical object~|p| into \ps@>@;
    start_bounds_code,stop_bounds_code: do_nothing;
    end; {all cases are enumerated}
    p:=link(p);
    end;
  print("showpage"); print_ln;
  print("%%EOF"); print_ln;
  a_close(ps_file);
  selector:=non_ps_setting;
  if internal[prologues]<=0 then clear_sizes;
  @<End progress report@>;
  end
else begin
@<Print the initial comment and give the bounding box for edge structure~|h|@>;
if (internal[prologues]>0) and (last_ps_fnum<last_fnum) then
  read_psname_table;
print("%%BeginProlog"); print_ln;
if (internal[prologues]>0)or(internal[mpprocset]>0) then @<Print the prologue@>;
print("%%EndProlog");
print_nl("%%Page: 1 1"); print_ln;
@<Print any pending specials@>;
unknown_graphics_state(0);
need_newpath:=true;
p:=link(dummy_loc(h));
while p<>null do
  begin if has_color(p) then
    if (pre_script(p))<>null then begin
      print_nl (pre_script(p)); print_ln;
      end;
  fix_graphics_state(p);
  case type(p) of
  @<Cases for translating graphical object~|p| into \ps@>@;
  start_bounds_code,stop_bounds_code: do_nothing;
  end; {all cases are enumerated}
  p:=link(p);
  end;
print("showpage"); print_ln;
print("%%EOF"); print_ln;
a_close(ps_file);
selector:=non_ps_setting;
if internal[prologues]<=0 then clear_sizes;
@<End progress report@>;
end;
if internal[tracing_output]>0 then print_edges(h," (just shipped out)",true);
end;

@ 
@d applied_reencoding(#)==((font_is_reencoded(#))and
    ((not font_is_subsetted(#))or(internal[prologues]=two)))

@d ps_print_defined_name(#)==ps_print(" /"); 
      if (font_is_subsetted(#)) then print(fm_font_subset_name(#))
      else begin print(font_ps_name[#]); 
        if applied_reencoding(#) then begin ps_print("-");
        ps_print(font_enc_name[#]); end;
        if fm_font_slant(#)<>0 then begin ps_print("-");
        ps_print("Slant"); print_int(fm_font_slant(#)) end;
        if fm_font_extend(#)<>0 then begin ps_print("-");
        ps_print("Extend"); print_int(fm_font_extend(#)) end;
      end

@<Print the improved prologue and setup@>=
begin 
  list_used_resources;
  list_supplied_resources;
  list_needed_resources;
  print_nl("%%EndComments");
  print_nl("%%BeginProlog");
  if internal[mpprocset]>0 then
    print_nl("%%BeginResource: procset mpost")
  else
    print_nl("%%BeginResource: procset mpost-minimal");
  print_nl("/bd{bind def}bind def/fshow {exch findfont exch scalefont setfont show}bd");
  if internal[mpprocset]>0 then begin
    print_nl("/hlw{0 dtransform exch truncate exch idtransform pop setlinewidth}bd");
    print_nl("/vlw{0 exch dtransform truncate idtransform setlinewidth pop}bd");
    print_nl("/l{lineto}bd/r{rlineto}bd/c{curveto}bd/m{moveto}bd/p{closepath}bd/n{newpath}bd");
    end;
  print_nl("/fcp{findfont dup length dict begin{1 index/FID ne{def}{pop pop}ifelse}forall}bd");
  print_nl("/fmc{FontMatrix dup length array copy dup dup}bd/fmd{/FontMatrix exch def}bd");
  print_nl("/Amul{4 -1 roll exch mul 1000 div}bd/ExtendFont{fmc 0 get Amul 0 exch put fmd}bd");
  print_nl("/SlantFont{fmc 2 get dup 0 eq{pop 1}if Amul FontMatrix 0 get mul 2 exch put fmd}bd");
  print_nl("%%EndResource");
  @<Include encodings and fonts  for edge structure~|h|@>;
  print_nl("%%EndProlog");
  print_nl("%%BeginSetup");
  print_ln;
  for f:=null_font+1 to last_fnum do begin
    if font_sizes[f]<>null then begin
      if hasfmentry(f) then begin
        @<Write font definition@>;
        ps_name_out(font_name[f],true);
        ps_print_defined_name(f);
        ps_print(" def");
        end
      else begin 
	begin_diagnostic;
        {selector:=term_and_log;}
	print_err("Warning: font ");
	print(font_name[f]);
	print(" cannot be found in any fontmapfile!");
	end_diagnostic(true);
        ps_name_out(font_name[f],true);
        ps_name_out(font_name[f],true);
        ps_print(" def");
        end;
      print_ln;
      end;
    end;
  print_nl("%%EndSetup");
  print_ln;
  print_nl("%%Page: 1 1");
  print_ln;
end

@ MAYBE: This postscript code is straight from the red book.
It could be a bit shortened by moving some of the commands
into a definition to be put in the PostScript dictionary.

TODO:  slant and narrowing
@<Write font definition@>=
if (applied_reencoding(f))
   or(fm_font_slant(f)<>0)
   or(fm_font_extend(f)<>0) then begin
  ps_name_out(font_ps_name[f],true);
  ps_print(" fcp");
  print_ln;
  if applied_reencoding(f) then begin
    ps_print("/Encoding ");
    ps_print(font_enc_name[f]);
    ps_print(" def ");
    end;
  if fm_font_slant(f)<>0 then begin
    print_int(fm_font_slant(f));
    ps_print(" SlantFont ");
    end;
  if fm_font_extend(f)<>0 then begin
    print_int(fm_font_extend(f));
    ps_print(" ExtendFont ");
    end;
  ps_print("currentdict end");
  print_ln;
  ps_print_defined_name(f);
  ps_print(" exch definefont pop");
  print_ln;
end

@ Included subset fonts do not need and encoding vector, make
sure we skip that case.

@p procedure list_used_resources;
label found,found2;
var @!f,ff:font_number; {fonts used in a text node or as loop counters}
@!ldf:font_number; {the last \.{DocumentFont} listed (otherwise |null_font|)}
firstitem:boolean; 
begin
if internal[mpprocset]>0 then
  print_nl("%%DocumentResources: procset mpost")
else
  print_nl("%%DocumentResources: procset mpost-minimal");
ldf:=null_font;
firstitem:=true;
for f:=null_font+1 to last_fnum do
  if (font_sizes[f]<>null)and(font_is_reencoded(f)) then
    begin
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_enc_name[f],font_enc_name[ff])=0 then
          goto found;
    if font_is_subsetted(f) then 
      goto found;
    if ps_offset+1+length(font_enc_name[f])>max_print_line then
      print_nl("%%+ encoding");
    if firstitem then begin
      firstitem:=false;
      print_nl("%%+ encoding");
      end;
    print_char(" ");
    print(font_enc_name[f]);
    ldf:=f;
    found:
    end;
ldf:=null_font;
firstitem:=true;
for f:=null_font+1 to last_fnum do
  if font_sizes[f]<>null then
    begin
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_name[f],font_name[ff])=0 then
          goto found2;
    if ps_offset+1+length(font_ps_name[f])>max_print_line then
      print_nl("%%+ font");
    if firstitem then begin
      firstitem:=false;
      print_nl("%%+ font");
      end;
    print_char(" ");
    print(font_ps_name[f]);
    ldf:=f;
    found2:
    end;
print_ln;
end;

@
@p procedure list_supplied_resources;
label found,found2;
var @!f,ff:font_number; {fonts used in a text node or as loop counters}
@!ldf:font_number; {the last \.{DocumentFont} listed (otherwise |null_font|)}
firstitem:boolean; 
begin
if internal[mpprocset]>0 then
  print_nl("%%DocumentSuppliedResources: procset mpost")
else
  print_nl("%%DocumentSuppliedResources: procset mpost-minimal");
ldf:=null_font;
firstitem:=true;
for f:=null_font+1 to last_fnum do
  if (font_sizes[f]<>null)and(font_is_reencoded(f)) then
    begin
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_enc_name[f],font_enc_name[ff])=0 then
          goto found;
    if (internal[prologues]=three)and(font_is_subsetted(f))then 
      goto found;
    if ps_offset+1+length(font_enc_name[f])>max_print_line then
      print_nl("%%+ encoding");
    if firstitem then begin
      firstitem:=false;
      print_nl("%%+ encoding");
      end;
    print_char(" ");
    print(font_enc_name[f]);
    ldf:=f;
    found:
    end;
ldf:=null_font;
firstitem:=true;
if internal[prologues]=three then begin
  for f:=null_font+1 to last_fnum do
  if font_sizes[f]<>null then
    begin
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_name[f],font_name[ff])=0 then
          goto found2;
    if not font_is_included(f) then 
      goto found2;
    if ps_offset+1+length(font_ps_name[f])>max_print_line then
      print_nl("%%+ font");
    if firstitem then begin
      firstitem:=false;
      print_nl("%%+ font");
      end;
    print_char(" ");
    print(font_ps_name[f]);
    ldf:=f;
    found2:
    end;
  print_ln;
end;
end;


@
@p procedure list_needed_resources;
label found;
var @!f,ff:font_number; {fonts used in a text node or as loop counters}
@!ldf:font_number; {the last \.{DocumentFont} listed (otherwise |null_font|)}
firstitem:boolean; 
begin
ldf:=null_font;
firstitem:=true;
for f:=null_font+1 to last_fnum do
  if font_sizes[f]<>null then
    begin
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_name[f],font_name[ff])=0 then
          goto found;
    if(internal[prologues]=three)and(font_is_included(f)) then 
      goto found;
    if ps_offset+1+length(font_ps_name[f])>max_print_line then
      print_nl("%%+ font");
    if firstitem then begin
      firstitem:=false;
      print_nl("%%DocumentNeededResources: font");
      end;
    print_char(" ");
    print(font_ps_name[f]);
    ldf:=f;
    found:
    end;
if not firstitem then
  print_ln;
end;

@
@<Print improved initial comment and bounding box for edge...@>=
print("%!PS-Adobe-3.0 EPSF-3.0");
print_nl("%%BoundingBox: ");
set_bbox(h,true);
if minx_val(h)>maxx_val(h) then print("0 0 0 0")
else begin ps_pair_out(floor_scaled(minx_val(h)),floor_scaled(miny_val(h)));
  ps_pair_out(-floor_scaled(-maxx_val(h)),-floor_scaled(-maxy_val(h)));
  end;
print_nl("%%HiResBoundingBox: ");
if minx_val(h)>maxx_val(h) then print("0 0 0 0")
else begin
  ps_pair_out(minx_val(h),miny_val(h));
  ps_pair_out(maxx_val(h),maxy_val(h));
  end;
print_nl("%%Creator: MetaPost ");
print(metapost_version);
print_nl("%%CreationDate: ");
print_int(round_unscaled(internal[year])); print_char(".");
print_dd(round_unscaled(internal[month])); print_char(".");
print_dd(round_unscaled(internal[day])); print_char(":");@/
t:=round_unscaled(internal[time]);
print_dd(t div 60); print_dd(t mod 60);@/
print_nl("%%Pages: 1");@/

@ 

@ @<Include encodings and fonts for edge structure~|h|@>=
mpfontencodings(last_fnum,(internal[prologues]=two));
@<Embed fonts that are available@>

@ @<Scan all the text nodes and mark the used ...@>=
for f:=null_font+1 to last_fnum do begin
  if font_sizes[f]<>null then begin
    unmark_font(f);
    font_sizes[f]:=null;
    end;
  if font_enc_name[f]<>0 then
    delete_str_ref(font_enc_name[f]);
  font_enc_name[f] := 0;
end;
for f:=null_font+1 to last_fnum do begin
  p:=link(dummy_loc(h));
  while p<>null do
    begin if type(p)=text_code then
      if font_n(p)<>null_font then begin
        font_sizes[font_n(p)] := void;
        mark_string_chars(font_n(p),text_p(p));	
	if hasfmentry(font_n(p)) then
          font_ps_name[font_n(p)] := fm_font_name(font_n(p));
        end;
    p:=link(p);
    end;
end

@ @<Update encoding names@>=
for f:=null_font+1 to last_fnum do begin
  p:=link(dummy_loc(h));
  while p<>null do
    begin if type(p)=text_code then
      if font_n(p)<>null_font then
	if hasfmentry(font_n(p)) then
          if font_enc_name[font_n(p)]=0 then
            font_enc_name[font_n(p)] := fm_encoding_name(font_n(p));
    p:=link(p);
    end;
end


@ @<Embed fonts that are available@>=
begin next_size:=0;
@<Make |cur_fsize| a copy of the |font_sizes| array@>;
repeat done_fonts:=true;
for f:=null_font+1 to last_fnum do
  begin if cur_fsize[f]<>null then begin 
      if internal[prologues]=three then
        if not dopsfont(f) then begin
           print_err("Font embedding failed");
	   error;
           end;
      cur_fsize[f]:=link(cur_fsize[f]);
      end;
    if cur_fsize[f]<>null then
      begin unmark_font(f); done_fonts:=false; @+end
    end;
  if not done_fonts then
    @<Increment |next_size| and apply |mark_string_chars| to all text nodes with
      that size index@>;
  until done_fonts;
end
@z

@x l. 22468
@<Print the prologue@>=
begin if ldf<>null_font then
  begin for f:=null_font+1 to last_fnum do
    if font_sizes[f]<>null then
      begin ps_name_out(font_name[f],true);
      ps_name_out(font_ps_name[f],true);
      ps_print(" def");
      print_ln;
      end;
  print("/fshow {exch findfont exch scalefont setfont show}bind def");
  print_ln;
  end;
end
@y
@<Print the prologue@>=
begin 
if ldf<>null_font then begin 
  if internal[prologues]>0 then begin
    for f:=null_font+1 to last_fnum do
    if font_sizes[f]<>null then
      begin ps_name_out(font_name[f],true);
      ps_name_out(font_ps_name[f],true);
      ps_print(" def");
      print_ln;
      end;
    if internal[mpprocset]=0 then
      print("/fshow {exch findfont exch scalefont setfont show}bind def");
    end;
  end;
if internal[mpprocset]>0 then begin
  if (internal[prologues]>0)and(ldf<>null_font) then
    print_nl("/bd{bind def}bind def/fshow {exch findfont exch scalefont setfont show}bd")
  else
    print_nl("/bd{bind def}bind def");
  print_nl("/hlw{0 dtransform exch truncate exch idtransform pop setlinewidth}bd");
  print_nl("/vlw{0 exch dtransform truncate idtransform setlinewidth pop}bd");
  print_nl("/l{lineto}bd/r{rlineto}bd/c{curveto}bd/m{moveto}bd/p{closepath}bd/n{newpath}bd");
  end;
print_ln;
end
@z

@x l. 22547
@ @<Shift or transform as necessary before outputting text node~|p| at...@>=
transformed:=(txx_val(p)<>scf)or(tyy_val(p)<>scf)or@|
  (txy_val(p)<>0)or(tyx_val(p)<>0);
if transformed then
  begin print("gsave [");
  ps_pair_out(make_scaled(txx_val(p),scf),@|make_scaled(tyx_val(p),scf));
  ps_pair_out(make_scaled(txy_val(p),scf),@|make_scaled(tyy_val(p),scf));
  ps_pair_out(tx_val(p),ty_val(p));@/
  ps_print("] concat 0 0 moveto");
  end
else begin ps_pair_out(tx_val(p),ty_val(p));
  ps_print("moveto");
  end;
print_ln
@y
@ @<Shift or transform as necessary before outputting text node~|p| at...@>=
transformed:=(txx_val(p)<>scf)or(tyy_val(p)<>scf)or@|
  (txy_val(p)<>0)or(tyx_val(p)<>0);
if transformed then
  begin print("gsave [");
  ps_pair_out(make_scaled(txx_val(p),scf),@|make_scaled(tyx_val(p),scf));
  ps_pair_out(make_scaled(txy_val(p),scf),@|make_scaled(tyy_val(p),scf));
  ps_pair_out(tx_val(p),ty_val(p));@/
  ps_print("] concat 0 0 ");
  end
else begin ps_pair_out(tx_val(p),ty_val(p));
  end;
ps_print_cmd("moveto","m");
print_ln
@z

@x l. 22965
@<Get the first line of input and prepare to start@>;
@y
@<Get the first line of input and prepare to start@>;
mp_init_map_file;
setjobid(internal[year],internal[month],internal[day],internal[time]);
@z
