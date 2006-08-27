% gstate.ch: implement a graphics state stack and the restoreclipcolor 
% internal


@x l. 4440
@d max_given_internal=34
@y
@d restore_clip_color=35
@d max_given_internal=35
@z

@x l. 4485
primitive("defaultcolormodel",internal_quantity,default_color_model);@/
@!@:default_color_model_}{\&{defaultcolormodel} primitive@>
@y
primitive("defaultcolormodel",internal_quantity,default_color_model);@/
@!@:default_color_model_}{\&{defaultcolormodel} primitive@>
primitive("restoreclipcolor",internal_quantity,restore_clip_color);@/
@!@:restore_clip_color_}{\&{restoreclipcolor} primitive@>
@z

@x l. 4900
internal[default_color_model]:=(rgb_model*unity);
@y
internal[default_color_model]:=(rgb_model*unity);
internal[restore_clip_color]:=unity;
@z

@x l. 4520
int_name[default_color_model]:="defaultcolormodel";
@y
int_name[default_color_model]:="defaultcolormodel";
int_name[restore_clip_color]:="restoreclipcolor";
@z

@x l.21584
@ We need to keep track of several parameters from the \ps\ graphics state.
@^graphics state@>
This allows us to be sure that \ps\ has the correct values when they are
needed without wasting time and space setting them unnecessarily.

@<Glob...@>=
@!gs_red,@!gs_green,@!gs_blue,@!gs_black:scaled;
 {color from the last \&{setcmykcolor} or \&{setrgbcolor} or \&{setgray} command}
@:setcmykcolor}{\&{setcmykcolor} command@>
@:setrgbcolor}{\&{setrgbcolor} command@>
@:setgray}{\&{setgray} command@>
@!gs_colormodel:quarterword; { the current colormodel }
@!gs_ljoin,@!gs_lcap:quarterword;
  {values from the last \&{setlinejoin} and \&{setlinecap} commands}
@:setlinejoin}{\&{setlinejoin} command@>
@:setlinecap}{\&{setlinecap} command@>
@!gs_miterlim:scaled; {the value from the last \&{setmiterlimit} command}
@:setmiterlimit}{\&{setmiterlimit} command@>
@!gs_dash_p:pointer; {edge structure for last \&{setdash} command}
@:setdash}{\&{setdash} command@>
@!gs_dash_sc:scaled; {scale factor used with |gs_dash_p|}
@!gs_width:scaled; {width setting or $-1$ if no \&{setlinewidth} command so far}
@!gs_adj_wx:boolean; {what resolution-dependent adjustment applies to the width}
@:setlinewidth}{\&{setlinewidth} command@>
@y
@ We need to keep track of several parameters from the \ps\ graphics state.
@^graphics state@>
This allows us to be sure that \ps\ has the correct values when they are
needed without wasting time and space setting them unnecessarily.

@d gs_node_size=10
@d gs_red       ==mem[gs_state+1].sc
@d gs_green     ==mem[gs_state+2].sc
@d gs_blue      ==mem[gs_state+3].sc
@d gs_black     ==mem[gs_state+4].sc
   {color from the last \&{setcmykcolor} or \&{setrgbcolor} or \&{setgray} command}
@d gs_colormodel==mem[gs_state+5].qqqq.b0 
   {the current colormodel}
@d gs_ljoin     ==mem[gs_state+5].qqqq.b1
@d gs_lcap      ==mem[gs_state+5].qqqq.b2
   {values from the last \&{setlinejoin} and \&{setlinecap} commands}
@d gs_adj_wx    ==mem[gs_state+5].qqqq.b3
   {what resolution-dependent adjustment applies to the width}
@d gs_miterlim  ==mem[gs_state+6].sc 
   {the value from the last \&{setmiterlimit} command}
@d gs_dash_p    ==mem[gs_state+7].hh.lh
   {edge structure for last \&{setdash} command}
@d gs_previous  ==mem[gs_state+7].hh.rh
   {backlink to the previous |gs_state| structure}
@d gs_dash_sc   ==mem[gs_state+8].sc 
   {scale factor used with |gs_dash_p|}
@d gs_width     ==mem[gs_state+9].sc 
   {width setting or $-1$ if no \&{setlinewidth} command so far}

@<Glob...@>=
gs_state:pointer;

@ @<Set init...@>=
gs_state:=null;
@z

@x l. 21587
@ To avoid making undue assumptions about the initial graphics state, these
parameters are given special values that are guaranteed not to match anything
in the edge structure being shipped out.  On the other hand, the initial color
should be black so that the translation of an all-black picture will have no
\&{setcolor} commands.  (These would be undesirable in a font application.)
Hence we use |c=0| when initializing the graphics state and we use |c<0|
to recover from a situation where we have lost track of the graphics state.

@<Declare the \ps\ output procedures@>=
procedure unknown_graphics_state(c:scaled);
begin gs_red:=c; gs_green:=c; gs_blue:=c; gs_black:=c;@/
gs_colormodel:=uninitialized_model;
gs_ljoin:=3;
gs_lcap:=3;
gs_miterlim:=0;@/
gs_dash_p:=void;
gs_dash_sc:=0;
gs_width:=-1;
end;
@y
@ To avoid making undue assumptions about the initial graphics state, these
parameters are given special values that are guaranteed not to match anything
in the edge structure being shipped out.  On the other hand, the initial color
should be black so that the translation of an all-black picture will have no
\&{setcolor} commands.  (These would be undesirable in a font application.)
Hence we use |c=0| when initializing the graphics state and we use |c<0|
to recover from a situation where we have lost track of the graphics state.

@<Declare the \ps\ output procedures@>=
procedure unknown_graphics_state(c:scaled);
var @!p:pointer; {to shift graphic states around}
  @!k:quarterword; {a loop index for copying the |gs_state|}
begin if (c=0)or(c=-1) then begin
  if gs_state=null then begin
    gs_state := get_node(gs_node_size);
    gs_previous:=null;
    end
  else begin 
    while gs_previous<>null do begin
      p := gs_previous;
      free_node(gs_state,gs_node_size);
      gs_state:=p;
      end;
    end;
  gs_red:=c; gs_green:=c; gs_blue:=c; gs_black:=c;@/
  gs_colormodel:=uninitialized_model;
  gs_ljoin:=3;
  gs_lcap:=3;
  gs_miterlim:=0;@/
  gs_dash_p:=void;
  gs_dash_sc:=0;
  gs_width:=-1;
  end
else if c=1 then begin
  p:= gs_state;
  gs_state := get_node(gs_node_size);
  for k:=1 to gs_node_size-1 do
    mem[gs_state+k]:=mem[p+k];
  gs_previous := p;
  end
else if c=2 then begin
  p := gs_previous;
  free_node(gs_state,gs_node_size);
  gs_state:=p;
  end;
end;
@z

@x l. 22482
@ Since we do not have a stack for the graphics state, it is considered
completely unknown after the \.{grestore} from a stop clip object.  Procedure
|unknown_graphics_state| needs a negative argument in this case.

@<Cases for translating graphical object~|p| into \ps@>=
start_clip_code:begin print_nl("gsave ");
  ps_path_out(path_p(p));
  ps_print(" clip");
  print_ln;
  end;
stop_clip_code:begin print_nl("grestore");
  print_ln;
  unknown_graphics_state(-1);
  end;
@y
@ @<Cases for translating graphical object~|p| into \ps@>=
start_clip_code:begin print_nl("gsave ");
  ps_path_out(path_p(p));
  ps_print(" clip");
  print_ln;
  if internal[restore_clip_color]>0 then
    unknown_graphics_state(1);
  end;
stop_clip_code:begin print_nl("grestore");
  print_ln;
  if internal[restore_clip_color]>0 then
    unknown_graphics_state(2)
  else
    unknown_graphics_state(-1);
  end;
@z