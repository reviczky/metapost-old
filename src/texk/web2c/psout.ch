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
mp_font_map:=xmalloc_array(fm_entry_ptr,font_max);

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
	if internal[prologues]>unity then begin
        print_char(" "); 
	    print_scaled(ww);
        ps_print(" hlw");
      end
    else begin
      print_char(" "); print_scaled(ww);
      ps_print(" 0 dtransform exch truncate exch idtransform pop setlinewidth");
      end;
    end
  else begin ps_room(15);
	if internal[prologues]>unity then begin
       print_char(" "); 
       print_scaled(ww);
       ps_print(" vlw");
      end
    else begin
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


@x
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
  @<Print the improved prologue@>;
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
  end
else begin
@<Print the initial comment and give the bounding box for edge structure~|h|@>;
if (internal[prologues]>0) and (last_ps_fnum<last_fnum) then
  read_psname_table;
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
end;
if internal[tracing_output]>0 then print_edges(h," (just shipped out)",true);
end;

@ 
@<Print the improved prologue@>=
begin 
  print_nl("%%DocumentProcSets: mpost");
  print_nl("%%DocumentSuppliedProcSets: mpost");
  print_nl("%%EndComments");
  print_nl("%%BeginProlog");
  print_nl("%%BeginResource: procset mpost");
  print_nl("/fshow {exch findfont exch scalefont setfont show}bind def");
  print_nl("/hlw {0 dtransform exch truncate exch idtransform pop setlinewidth}bind def");
  print_nl("/vlw {0 exch dtransform truncate idtransform setlinewidth pop}bind def");
  print_nl("%%EndResource");
  print_nl("%%EndProlog");
  print_nl("%%BeginSetup");
  print_ln;
  if ldf<>null_font then
    begin for f:=null_font+1 to last_fnum do
    if font_sizes[f]<>null then
      begin ps_name_out(font_name[f],true);
      ps_name_out(font_ps_name[f],true);
      ps_print(" def");
      print_ln;
      end;
  print_nl("%%EndSetup");
  print_ln;
  end;
end

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
@<Better list of all the fonts and magnifications for edge structure~|h|@>;
print_ln

@ 
@<Better list of all the fonts and magnifications for edge structure~|h|@>=
@<Scan all the text nodes and set the |font_sizes| lists;
  if |internal[prologues]<=0| list the sizes selected by |choose_scale|,
  apply |unmark_font| to each font encountered, and call |mark_string|
  whenever the size index is zero@>;
mpfontencodings(last_fnum);
@<Give the complete \.{DocumentFonts} comment@>;
if internal[prologues]=two then
  @<Give a \.{DocumentNeededFonts} comment@>
else begin 
  do_nothing;
  {next_size:=0;
  @<Make |cur_fsize| a copy of the |font_sizes| array@>;
  repeat done_fonts:=true;
  for f:=null_font+1 to last_fnum do
    begin if cur_fsize[f]<>null then
      @<Print the \.{\%*Font} comment for font |f| and advance |cur_fsize[f]|@>;
    if cur_fsize[f]<>null then
      begin unmark_font(f); done_fonts:=false; @+end;
    end;
  if not done_fonts then
    @<Increment |next_size| and apply |mark_string_chars| to all text nodes with
      that size index@>;
  until done_fonts;}
  end

@ @<Give the complete \.{DocumentFonts} comment@>=
begin ldf:=null_font;
for f:=null_font+1 to last_fnum do
  if font_sizes[f]<>null then
    begin if ldf=null_font then print_nl("%%DocumentFonts:");
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_ps_name[f],font_ps_name[ff])=0 then
          goto found3;
    if ps_offset+1+length(font_ps_name[f])>max_print_line then
      print_nl("%%+");
    print_char(" ");
    print(font_ps_name[f]);
    ldf:=f;
    found3:
    end;
end

@ @<Give a \.{DocumentNeededFonts} comment@>=
begin ldf:=null_font;
for f:=null_font+1 to last_fnum do
  if font_sizes[f]<>null then
    begin if ldf=null_font then print_nl("%%DocumentNeededFonts:");
    for ff:=ldf downto null_font do
      if font_sizes[ff]<>null then
        if str_vs_str(font_ps_name[f],font_ps_name[ff])=0 then
          goto found2;
    if ps_offset+1+length(font_ps_name[f])>max_print_line then
      print_nl("%%+");
    print_char(" ");
    print(font_ps_name[f]);
    ldf:=f;
    found2:
    end;
end


@z

@x l. 22965
@<Get the first line of input and prepare to start@>;
@y
@<Get the first line of input and prepare to start@>;
mp_init_map_file('mpost.map');
@z
