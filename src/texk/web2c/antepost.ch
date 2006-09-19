% antepost.ch: Implements withprescript and withpostscript specials

@x l. 1630
ps_file_only: begin wps(xchr[s]); incr(ps_offset);
  end;
@y
ps_file_only: if s=13 then begin 
   wps_cr; ps_offset:=0;
   end
  else 
    begin
    wps(xchr[s]); incr(ps_offset);
    end;
@z

@x l. 8102
@d fill_node_size=8
@y
@d pre_script(#)==mem[#+8].hh.lh
@d post_script(#)==mem[#+8].hh.rh
@d fill_node_size=9
@z

@x l. 8116
  color_model(t):=uninitialized_model;
@y
  color_model(t):=uninitialized_model;
  pre_script(t):=null;
  post_script(t):=null;
@z

@x l. 8135
@d dash_p(#)==link(#+8)
  {a pointer to the edge structure that gives the dash pattern}
@d lcap_val(#)==type(#+8)
  {the value of \&{linecap}}
@:linecap_}{\&{linecap} primitive@>
@d dash_scale(#)==mem[#+9].sc {dash lengths are scaled by this factor}
@d stroked_node_size=10
@y
@d dash_p(#)==link(#+9)
  {a pointer to the edge structure that gives the dash pattern}
@d lcap_val(#)==type(#+9)
  {the value of \&{linecap}}
@:linecap_}{\&{linecap} primitive@>
@d dash_scale(#)==mem[#+10].sc {dash lengths are scaled by this factor}
@d stroked_node_size=11
@z

@x l. 8157
  color_model(t):=uninitialized_model;
@y
  color_model(t):=uninitialized_model;
  pre_script(t):=null;
  post_script(t):=null;
@z

@x l. 8227
@d height_val(#)==mem[#+8].sc  {unscaled height of the text}
@d depth_val(#)==mem[#+9].sc  {unscaled depth of the text}
@d text_tx_loc(#)==#+10
  {the first of six locations for transformation parameters}
@d tx_val(#)==mem[#+10].sc  {$x$ shift amount}
@d ty_val(#)==mem[#+11].sc  {$y$ shift amount}
@d txx_val(#)==mem[#+12].sc  {|txx| transformation parameter}
@d txy_val(#)==mem[#+13].sc  {|txy| transformation parameter}
@d tyx_val(#)==mem[#+14].sc  {|tyx| transformation parameter}
@d tyy_val(#)==mem[#+15].sc  {|tyy| transformation parameter}
@d text_trans_part(#)==mem[#+10-x_part].sc
    {interpret a text node ponter that has been offset by |x_part..yy_part|}
@d text_node_size=16
@y
@d height_val(#)==mem[#+9].sc  {unscaled height of the text}
@d depth_val(#)==mem[#+10].sc  {unscaled depth of the text}
@d text_tx_loc(#)==#+11
  {the first of six locations for transformation parameters}
@d tx_val(#)==mem[#+11].sc  {$x$ shift amount}
@d ty_val(#)==mem[#+12].sc  {$y$ shift amount}
@d txx_val(#)==mem[#+13].sc  {|txx| transformation parameter}
@d txy_val(#)==mem[#+14].sc  {|txy| transformation parameter}
@d tyx_val(#)==mem[#+15].sc  {|tyx| transformation parameter}
@d tyy_val(#)==mem[#+16].sc  {|tyy| transformation parameter}
@d text_trans_part(#)==mem[#+11-x_part].sc
    {interpret a text node ponter that has been offset by |x_part..yy_part|}
@d text_node_size=17
@z

@x l. 8239
  color_model(t):=uninitialized_model;
@y
  color_model(t):=uninitialized_model;
  pre_script(t):=null;
  post_script(t):=null;
@z

@x l. 8428
@ @<Prepare to recycle graphical object |p|@>=
case type(p) of
fill_code: begin toss_knot_list(path_p(p));
  if pen_p(p)<>null then toss_knot_list(pen_p(p));
  end;
stroked_code: begin toss_knot_list(path_p(p));
  if pen_p(p)<>null then toss_knot_list(pen_p(p));
  e:=dash_p(p);
  end;
text_code: delete_str_ref(text_p(p));
@y
@ @<Prepare to recycle graphical object |p|@>=
case type(p) of
fill_code: begin toss_knot_list(path_p(p));
  if pen_p(p)<>null then toss_knot_list(pen_p(p));
  if pre_script(p)<>null then delete_str_ref(pre_script(p));
  if post_script(p)<>null then delete_str_ref(post_script(p));
  end;
stroked_code: begin toss_knot_list(path_p(p));
  if pen_p(p)<>null then toss_knot_list(pen_p(p));
  if pre_script(p)<>null then delete_str_ref(pre_script(p));
  if post_script(p)<>null then delete_str_ref(post_script(p));
  e:=dash_p(p);
  end;
text_code: begin 
  delete_str_ref(text_p(p));
  if pre_script(p)<>null then delete_str_ref(pre_script(p));
  if post_script(p)<>null then delete_str_ref(post_script(p));
  end;
@z

@x l. 19300
@d also_code=2 {command modifier for `\&{also}'}
@y
@d also_code=2 {command modifier for `\&{also}'}

@ Pre and postscripts need two new identifiers:

@d with_pre_script=11
@d with_post_script=13
@z

@x l. 19335
primitive("dashed",with_option,picture_type);@/
@!@:dashed_}{\&{dashed} primitive@>
@y
primitive("dashed",with_option,picture_type);@/
@!@:dashed_}{\&{dashed} primitive@>
primitive("withprescript",with_option,with_pre_script);@/
@!@:with_pre_script_}{\&{withprescript} primitive@>
primitive("withpostscript",with_option,with_post_script);@/
@!@:with_post_script_}{\&{withpostscript} primitive@>
@z

@x l. 19344
with_option:if m=pen_type then print("withpen")
@y
with_option:if m=pen_type then print("withpen")
  else if m=with_pre_script then print("withprescript")
  else if m=with_post_script then print("withpostscript")
@z

@x l. 19358
@!cp,@!pp,@!dp:pointer;
  {objects being updated; |void| initially; |null| to suppress update}
begin cp:=void; pp:=void; dp:=void;
@y
@!old_setting:0..max_selector; {saved |selector| setting}
@!k:pointer; {for finding the near-last item in a list }
@!s:str_number; {for string cleanup after combining }
@!cp,@!pp,@!dp,@!ap,@!bp:pointer;
  {objects being updated; |void| initially; |null| to suppress update}
begin cp:=void; pp:=void; dp:=void; ap:=void; bp:=void;
@z

@x l. 19363
  if ((t=uninitialized_model)and
@y
  if ((t=with_pre_script)and(cur_type<>string_type))or
     ((t=with_post_script)and(cur_type<>string_type))or
     ((t=uninitialized_model)and
@z

@x l. 19371
      begin if pp=void then @<Make |pp| an object in list~|p| that needs
          a pen@>;
      if pp<>null then
        begin if pen_p(pp)<>null then toss_knot_list(pen_p(pp));
        pen_p(pp):=cur_exp; cur_type:=vacuous;
        end;
      end
@y
      begin if pp=void then @<Make |pp| an object in list~|p| that needs
          a pen@>;
      if pp<>null then
        begin if pen_p(pp)<>null then toss_knot_list(pen_p(pp));
        pen_p(pp):=cur_exp; cur_type:=vacuous;
        end;
      end
    else if t=with_pre_script then
       begin if ap=void then
         ap:=p;
         while (ap<>null)and(not has_color(ap)) do
            ap:=link(ap);
         if ap<>null then
           begin if pre_script(ap)<>null then begin { build a new,combined string }
             s:=pre_script(ap);
             old_setting:=selector; 
	     selector:=new_string;
             str_room(length(pre_script(ap))+length(cur_exp)+2);
	     print(cur_exp); 
             append_char(13);  {a forced \ps\ newline }
             print(pre_script(ap));
             pre_script(ap):=make_string;
             delete_str_ref(s);
             selector:=old_setting;
             end 
           else
             pre_script(ap):=cur_exp;
           cur_type:=vacuous;
           end;
         end
    else if t=with_post_script then
       begin if bp=void then
         k:=p; bp:=k;
         while link(k)<>null do begin
            k:=link(k);
            if has_color(k) then bp:=k;
            end;    
         if bp<>null then
           begin if post_script(bp)<>null then begin 
             s:=post_script(bp);
             old_setting:=selector; 
	     selector:=new_string;
             str_room(length(post_script(bp))+length(cur_exp)+2);
             print(post_script(bp));
             append_char(13); {a forced \ps\ newline }
	     print(cur_exp); 
             post_script(bp):=make_string;
             delete_str_ref(s);
             selector:=old_setting;
             end
           else 
             post_script(bp):=cur_exp; 
           cur_type:=vacuous;
           end;
         end
@z


@x l. 19369
if t=picture_type then
@y
if t=with_pre_script then
  help_line[1]:="Next time say `withprescript <known string expression>';"
else if t=with_post_script then
  help_line[1]:="Next time say `withpostscript <known string expression>';"
else if t=picture_type then
@z

@x l. 22299
  begin fix_graphics_state(p);
@y
  begin if has_color(p) then
    if (pre_script(p))<>null then begin
      print_nl (pre_script(p)); print_ln;
      end;
  fix_graphics_state(p);
@z

@x l. 23011
fill_code: if pen_p(p)=null then ps_fill_out(path_p(p))
  else if pen_is_elliptical(pen_p(p)) then stroke_ellipse(p,true)
  else begin do_outer_envelope(copy_path(path_p(p)), p);
    do_outer_envelope(htap_ypoc(path_p(p)), p);
    end;
stroked_code: if pen_is_elliptical(pen_p(p)) then stroke_ellipse(p,false)
  else begin q:=copy_path(path_p(p));
    t:=lcap_val(p);
    @<Break the cycle and set |t:=1| if path |q| is cyclic@>;
    q:=make_envelope(q,pen_p(p),ljoin_val(p),t,miterlim_val(p));
    ps_fill_out(q);
    toss_knot_list(q);
    end;
@y
fill_code: begin
  if pen_p(p)=null then ps_fill_out(path_p(p))
  else if pen_is_elliptical(pen_p(p)) then stroke_ellipse(p,true)
  else begin do_outer_envelope(copy_path(path_p(p)), p);
    do_outer_envelope(htap_ypoc(path_p(p)), p);
    end;
  if (post_script(p))<>null then begin
    print_nl (post_script(p)); print_ln;
    end;
  end;
stroked_code: begin
  if pen_is_elliptical(pen_p(p)) then stroke_ellipse(p,false)
  else begin q:=copy_path(path_p(p));
    t:=lcap_val(p);
    @<Break the cycle and set |t:=1| if path |q| is cyclic@>;
    q:=make_envelope(q,pen_p(p),ljoin_val(p),t,miterlim_val(p));
    ps_fill_out(q);
    toss_knot_list(q);
    end;
  if (post_script(p))<>null then begin
    print_nl (post_script(p)); print_ln;
    end;
  end;
@z

@x l. 23038
text_code: if (font_n(p)<>null_font) and (length(text_p(p))>0) then
  begin if internal[prologues]>0 then
    scf:=choose_scale(p)
  else scf:=indexed_size(font_n(p), name_type(p));
  @<Shift or transform as necessary before outputting text node~|p| at scale
    factor~|scf|; set |transformed:=true| if the original transformation must
    be restored@>;
  ps_string_out(text_p(p));
  ps_name_out(font_name[font_n(p)],false);
  @<Print the size information and \ps\ commands for text node~|p|@>;
  print_ln;
  end;
@y
text_code: begin
  if (font_n(p)<>null_font) and (length(text_p(p))>0) then
  begin if internal[prologues]>0 then
    scf:=choose_scale(p)
  else scf:=indexed_size(font_n(p), name_type(p));
  @<Shift or transform as necessary before outputting text node~|p| at scale
    factor~|scf|; set |transformed:=true| if the original transformation must
    be restored@>;
  ps_string_out(text_p(p));
  ps_name_out(font_name[font_n(p)],false);
  @<Print the size information and \ps\ commands for text node~|p|@>;
  print_ln;
  end;
  if (post_script(p))<>null then begin
    print_nl (post_script(p)); print_ln;
    end;
  end;
@z