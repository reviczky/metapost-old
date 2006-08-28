@x l. 4085
@d color_type=13 {\&{color} variable or capsule}
@d pair_type=14 {\&{pair} variable or capsule}
@d numeric_type=15 {variable that has been declared \&{numeric} but not used}
@d known=16 {\&{numeric} with a known value}
@d dependent=17 {a linear combination with |fraction| coefficients}
@d proto_dependent=18 {a linear combination with |scaled| coefficients}
@d independent=19 {\&{numeric} with unknown value}
@d token_list=20 {variable name or suffix argument or text argument}
@d structured=21 {variable with subscripts and attributes}
@d unsuffixed_macro=22 {variable defined with \&{vardef} but no \.{\AT!\#}}
@d suffixed_macro=23 {variable defined with \&{vardef} and \.{\AT!\#}}
@y
@d color_type=13 {\&{color} variable or capsule}
@d cmykcolor_type=14 {\&{cmykcolor} variable or capsule}
@d pair_type=15 {\&{pair} variable or capsule}
@d numeric_type=16 {variable that has been declared \&{numeric} but not used}
@d known=17 {\&{numeric} with a known value}
@d dependent=18 {a linear combination with |fraction| coefficients}
@d proto_dependent=19 {a linear combination with |scaled| coefficients}
@d independent=20 {\&{numeric} with unknown value}
@d token_list=21 {variable name or suffix argument or text argument}
@d structured=22 {variable with subscripts and attributes}
@d unsuffixed_macro=23 {variable defined with \&{vardef} but no \.{\AT!\#}}
@d suffixed_macro=24 {variable defined with \&{vardef} and \.{\AT!\#}}
@z

@x l. 4115
color_type:print("color");
@y
color_type:print("color");
cmykcolor_type:print("cmykcolor");
@z

@x l. 4145
@d red_part_sector=11 {|name_type| in the \&{redpart} of a node}
@d green_part_sector=12 {|name_type| in the \&{greenpart} of a node}
@d blue_part_sector=13 {|name_type| in the \&{bluepart} of a node}
@d capsule=14 {|name_type| in stashed-away subexpressions}
@d token=15 {|name_type| in a numeric token or string token}
@y
@d red_part_sector=11 {|name_type| in the \&{redpart} of a node}
@d green_part_sector=12 {|name_type| in the \&{greenpart} of a node}
@d blue_part_sector=13 {|name_type| in the \&{bluepart} of a node}
@d cyan_part_sector=14 {|name_type| in the \&{redpart} of a node}
@d magenta_part_sector=15 {|name_type| in the \&{greenpart} of a node}
@d yellow_part_sector=16 {|name_type| in the \&{bluepart} of a node}
@d black_part_sector=17 {|name_type| in the \&{greenpart} of a node}
@d grey_part_sector=18 {|name_type| in the \&{bluepart} of a node}
@d capsule=19 {|name_type| in stashed-away subexpressions}
@d token=20 {|name_type| in a numeric token or string token}
@z

@x l. 4194
@d x_part=54 {operation code for \.{xpart}}
@d y_part=55 {operation code for \.{ypart}}
@d xx_part=56 {operation code for \.{xxpart}}
@d xy_part=57 {operation code for \.{xypart}}
@d yx_part=58 {operation code for \.{yxpart}}
@d yy_part=59 {operation code for \.{yypart}}
@d red_part=60 {operation code for \.{redpart}}
@d green_part=61 {operation code for \.{greenpart}}
@d blue_part=62 {operation code for \.{bluepart}}
@d font_part=63 {operation code for \.{fontpart}}
@d text_part=64 {operation code for \.{textpart}}
@d path_part=65 {operation code for \.{pathpart}}
@d pen_part=66 {operation code for \.{penpart}}
@d dash_part=67 {operation code for \.{dashpart}}
@d sqrt_op=68 {operation code for \.{sqrt}}
@d m_exp_op=69 {operation code for \.{mexp}}
@d m_log_op=70 {operation code for \.{mlog}}
@d sin_d_op=71 {operation code for \.{sind}}
@d cos_d_op=72 {operation code for \.{cosd}}
@d floor_op=73 {operation code for \.{floor}}
@d uniform_deviate=74 {operation code for \.{uniformdeviate}}
@d char_exists_op=75 {operation code for \.{charexists}}
@d font_size=76 {operation code for \.{fontsize}}
@d ll_corner_op=77 {operation code for \.{llcorner}}
@d lr_corner_op=78 {operation code for \.{lrcorner}}
@d ul_corner_op=79 {operation code for \.{ulcorner}}
@d ur_corner_op=80 {operation code for \.{urcorner}}
@d arc_length=81 {operation code for \.{arclength}}
@d angle_op=82 {operation code for \.{angle}}
@d cycle_op=83 {operation code for \.{cycle}}
@d filled_op=84 {operation code for \.{filled}}
@d stroked_op=85 {operation code for \.{stroked}}
@d textual_op=86 {operation code for \.{textual}}
@d clipped_op=87 {operation code for \.{clipped}}
@d bounded_op=88 {operation code for \.{bounded}}
@d plus=89 {operation code for \.+}
@d minus=90 {operation code for \.-}
@d times=91 {operation code for \.*}
@d over=92 {operation code for \./}
@d pythag_add=93 {operation code for \.{++}}
@d pythag_sub=94 {operation code for \.{+-+}}
@d or_op=95 {operation code for \.{or}}
@d and_op=96 {operation code for \.{and}}
@d less_than=97 {operation code for \.<}
@d less_or_equal=98 {operation code for \.{<=}}
@d greater_than=99 {operation code for \.>}
@d greater_or_equal=100 {operation code for \.{>=}}
@d equal_to=101 {operation code for \.=}
@d unequal_to=102 {operation code for \.{<>}}
@d concatenate=103 {operation code for \.\&}
@d rotated_by=104 {operation code for \.{rotated}}
@d slanted_by=105 {operation code for \.{slanted}}
@d scaled_by=106 {operation code for \.{scaled}}
@d shifted_by=107 {operation code for \.{shifted}}
@d transformed_by=108 {operation code for \.{transformed}}
@d x_scaled=109 {operation code for \.{xscaled}}
@d y_scaled=110 {operation code for \.{yscaled}}
@d z_scaled=111 {operation code for \.{zscaled}}
@d in_font=112 {operation code for \.{infont}}
@d intersect=113 {operation code for \.{intersectiontimes}}
@d double_dot=114 {operation code for improper \.{..}}
@d substring_of=115 {operation code for \.{substring}}
@d min_of=substring_of
@d subpath_of=116 {operation code for \.{subpath}}
@d direction_time_of=117 {operation code for \.{directiontime}}
@d point_of=118 {operation code for \.{point}}
@d precontrol_of=119 {operation code for \.{precontrol}}
@d postcontrol_of=120 {operation code for \.{postcontrol}}
@d pen_offset_of=121 {operation code for \.{penoffset}}
@d arc_time_of=122 {operation code for \.{arctime}}
@d mp_version=123 {operation code for \.{mpversion}}
@y
@d color_model_part=54 {operation code for \.{colormodel}}
@d x_part=55 {operation code for \.{xpart}}
@d y_part=56 {operation code for \.{ypart}}
@d xx_part=57 {operation code for \.{xxpart}}
@d xy_part=58 {operation code for \.{xypart}}
@d yx_part=59 {operation code for \.{yxpart}}
@d yy_part=60 {operation code for \.{yypart}}
@d red_part=61 {operation code for \.{redpart}}
@d green_part=62 {operation code for \.{greenpart}}
@d blue_part=63 {operation code for \.{bluepart}}
@d cyan_part=64 {operation code for \.{cyanpart}}
@d magenta_part=65 {operation code for \.{magentapart}}
@d yellow_part=66 {operation code for \.{yellowpart}}
@d black_part=67 {operation code for \.{blackpart}}
@d grey_part=68 {operation code for \.{greypart}}
@d font_part=69 {operation code for \.{fontpart}}
@d text_part=70 {operation code for \.{textpart}}
@d path_part=71 {operation code for \.{pathpart}}
@d pen_part=72 {operation code for \.{penpart}}
@d dash_part=73 {operation code for \.{dashpart}}
@d sqrt_op=74 {operation code for \.{sqrt}}
@d m_exp_op=75 {operation code for \.{mexp}}
@d m_log_op=76 {operation code for \.{mlog}}
@d sin_d_op=77 {operation code for \.{sind}}
@d cos_d_op=78 {operation code for \.{cosd}}
@d floor_op=79 {operation code for \.{floor}}
@d uniform_deviate=80 {operation code for \.{uniformdeviate}}
@d char_exists_op=81 {operation code for \.{charexists}}
@d font_size=82 {operation code for \.{fontsize}}
@d ll_corner_op=83 {operation code for \.{llcorner}}
@d lr_corner_op=84 {operation code for \.{lrcorner}}
@d ul_corner_op=85 {operation code for \.{ulcorner}}
@d ur_corner_op=86 {operation code for \.{urcorner}}
@d arc_length=87 {operation code for \.{arclength}}
@d angle_op=88 {operation code for \.{angle}}
@d cycle_op=89 {operation code for \.{cycle}}
@d filled_op=90 {operation code for \.{filled}}
@d stroked_op=91 {operation code for \.{stroked}}
@d textual_op=92 {operation code for \.{textual}}
@d clipped_op=93 {operation code for \.{clipped}}
@d bounded_op=94 {operation code for \.{bounded}}
@d plus=95 {operation code for \.+}
@d minus=96 {operation code for \.-}
@d times=97 {operation code for \.*}
@d over=98 {operation code for \./}
@d pythag_add=99 {operation code for \.{++}}
@d pythag_sub=100 {operation code for \.{+-+}}
@d or_op=101 {operation code for \.{or}}
@d and_op=102 {operation code for \.{and}}
@d less_than=103 {operation code for \.<}
@d less_or_equal=104 {operation code for \.{<=}}
@d greater_than=105 {operation code for \.>}
@d greater_or_equal=106 {operation code for \.{>=}}
@d equal_to=107 {operation code for \.=}
@d unequal_to=108 {operation code for \.{<>}}
@d concatenate=109 {operation code for \.\&}
@d rotated_by=110 {operation code for \.{rotated}}
@d slanted_by=111 {operation code for \.{slanted}}
@d scaled_by=112 {operation code for \.{scaled}}
@d shifted_by=113 {operation code for \.{shifted}}
@d transformed_by=114 {operation code for \.{transformed}}
@d x_scaled=115 {operation code for \.{xscaled}}
@d y_scaled=116 {operation code for \.{yscaled}}
@d z_scaled=117 {operation code for \.{zscaled}}
@d in_font=118 {operation code for \.{infont}}
@d intersect=119 {operation code for \.{intersectiontimes}}
@d double_dot=120 {operation code for improper \.{..}}
@d substring_of=121 {operation code for \.{substring}}
@d min_of=substring_of
@d subpath_of=122 {operation code for \.{subpath}}
@d direction_time_of=123 {operation code for \.{directiontime}}
@d point_of=124 {operation code for \.{point}}
@d precontrol_of=125 {operation code for \.{precontrol}}
@d postcontrol_of=126 {operation code for \.{postcontrol}}
@d pen_offset_of=127 {operation code for \.{penoffset}}
@d arc_time_of=128 {operation code for \.{arctime}}
@d mp_version=129 {operation code for \.{mpversion}}
@z

@x l. 4293
red_part:print("redpart");
green_part:print("greenpart");
blue_part:print("bluepart");
@y
red_part:print("redpart");
green_part:print("greenpart");
blue_part:print("bluepart");
cyan_part:print("cyanpart");
magenta_part:print("magentapart");
yellow_part:print("yellowpart");
black_part:print("blackpart");
grey_part:print("greypart");
color_model_part:print("colormodel");
@z

@x l. 4397
@d true_corners=33 {positive to make \&{llcorner} etc. ignore \&{setbounds}}
@d max_given_internal=33
@y
@d true_corners=33 {positive to make \&{llcorner} etc. ignore \&{setbounds}}
@d default_color_model=34 {the default color model for unspecified items}
@d max_given_internal=34
@z

@x l. 4480
primitive("truecorners",internal_quantity,true_corners);@/
@!@:true_corners_}{\&{truecorners} primitive@>
@y
primitive("truecorners",internal_quantity,true_corners);@/
@!@:true_corners_}{\&{truecorners} primitive@>
primitive("defaultcolormodel",internal_quantity,default_color_model);@/
@!@:default_color_model_}{\&{defaultcolormodel} primitive@>

@ Colors can be specified in four color models. In the special 
case of |no_model|, MetaPost does not output any color operator to
the postscript output. 

Note: these values are passed directly on to |with_option|. This only
works because the other possible values passed to |with_option| are 
8 and 10 respectively (from |with_pen| and |with_picture|).

There is a first state, that is only used for |gs_colormodel|. It flags
the fact that there has not been any kind of color specification by
the user so far in the game.

@d no_model=1
@d grey_model=3
@d rgb_model=5
@d cmyk_model=7
@d uninitialized_model=9

@<Initialize table entries (done by \.{INIMP} only)@>=
internal[default_color_model]:=(rgb_model*unity);
@z


@x l. 4519
int_name[true_corners]:="truecorners";
@y
int_name[true_corners]:="truecorners";
int_name[default_color_model]:="defaultcolormodel";
@z

@x l. 5033
    unknown_types,pen_type,path_type,picture_type,pair_type,color_type,
    transform_type,dependent,proto_dependent,independent:
@y
    unknown_types,pen_type,path_type,picture_type,pair_type,color_type,
    cmykcolor_type,transform_type,dependent,proto_dependent,independent:
@z

@x l. 5411
@d red_part_loc(#)==# {where the \&{redpart} is found in a color node}
@d green_part_loc(#)==#+2 {where the \&{greenpart} is found in a color node}
@d blue_part_loc(#)==#+4 {where the \&{bluepart} is found in a color node}
@#
@d pair_node_size=4 {the number of words in a pair node}
@d transform_node_size=12 {the number of words in a transform node}
@d color_node_size=6 {the number of words in a color node}
@y
@d red_part_loc(#)==# {where the \&{redpart} is found in a color node}
@d green_part_loc(#)==#+2 {where the \&{greenpart} is found in a color node}
@d blue_part_loc(#)==#+4 {where the \&{bluepart} is found in a color node}
@d cyan_part_loc(#)==# {where the \&{cyanpart} is found in a color node}
@d magenta_part_loc(#)==#+2 {where the \&{magentapart} is found in a color node}
@d yellow_part_loc(#)==#+4 {where the \&{yellowpart} is found in a color node}
@d black_part_loc(#)==#+6 {where the \&{blackpart} is found in a color node}
@d grey_part_loc(#)==# {where the \&{greypart} is found in a color node}
@#
@d pair_node_size=4 {the number of words in a pair node}
@d transform_node_size=12 {the number of words in a transform node}
@d color_node_size=6 {the number of words in a color node}
@d cmykcolor_node_size=8 {the number of words in a color node}
@z

@x
@!sector_offset:array[x_part_sector..blue_part_sector] of small_number;
@y
@!sector_offset:array[x_part_sector..black_part_sector] of small_number;
@z

@x l. 5431
big_node_size[transform_type]:=transform_node_size;
big_node_size[pair_type]:=pair_node_size;
big_node_size[color_type]:=color_node_size;
sector0[transform_type]:=x_part_sector;
sector0[pair_type]:=x_part_sector;
sector0[color_type]:=red_part_sector;
for k:=x_part_sector to yy_part_sector do
  sector_offset[k]:=2*(k-x_part_sector);
for k:=red_part_sector to blue_part_sector do
  sector_offset[k]:=2*(k-red_part_sector);
@y
big_node_size[transform_type]:=transform_node_size;
big_node_size[pair_type]:=pair_node_size;
big_node_size[color_type]:=color_node_size;
big_node_size[cmykcolor_type]:=cmykcolor_node_size;
sector0[transform_type]:=x_part_sector;
sector0[pair_type]:=x_part_sector;
sector0[color_type]:=red_part_sector;
sector0[cmykcolor_type]:=cyan_part_sector;
for k:=x_part_sector to yy_part_sector do
  sector_offset[k]:=2*(k-x_part_sector);
for k:=red_part_sector to blue_part_sector do
  sector_offset[k]:=2*(k-red_part_sector);
for k:=cyan_part_sector to black_part_sector do
  sector_offset[k]:=2*(k-cyan_part_sector);
@z

@x l. 5530
blue_part_sector: print("blue");
@y
blue_part_sector: print("blue");
cyan_part_sector: print("cyan");
magenta_part_sector: print("magenta");
yellow_part_sector: print("yellow");
black_part_sector: print("black");
grey_part_sector: print("grey");
@z

@x l. 5799
transform_type,color_type,pair_type,numeric_type:und_type:=type(p);
@y
transform_type,color_type,cmykcolor_type,
pair_type,numeric_type:und_type:=type(p);
@z

@x l. 8003
@ Let's consider the types of graphical objects one at a time.
First of all, a filled contour is represented by a six-word node.  The first
word contains |type| and |link| fields, and the next four words contain a
pointer to a cyclic path and the value to use for \ps' \&{currentrgbcolor}
parameter.  If a pen is used for filling |pen_p|, |ljoin_val| and |miterlim_val|
give the relevant information.

@d path_p(#)==link(#+1)
  {a pointer to the path that needs filling}
@d pen_p(#)==info(#+1)
  {a pointer to the pen to fill or stroke with}
@d obj_red_loc(#)==#+2  {the first of three locations for the color}
@d red_val(#)==mem[#+2].sc
  {the red component of the color in the range $0\ldots1$}
@d green_val(#)==mem[#+3].sc
  {the green component of the color in the range $0\ldots1$}
@d blue_val(#)==mem[#+4].sc
  {the blue component of the color in the range $0\ldots1$}
@d ljoin_val(#)==name_type(#)  {the value of \&{linejoin}}
@:linejoin_}{\&{linejoin} primitive@>
@d miterlim_val(#)==mem[#+5].sc  {the value of \&{miterlimit}}
@:miterlimit_}{\&{miterlimit} primitive@>
@d obj_color_part(#)==mem[#+2-red_part].sc
  {interpret an object pointer that has been offset by |red_part..blue_part|}
@d fill_node_size=6
@d fill_code=1

@p function new_fill_node(@!p: pointer): pointer;
  {make a fill node for cyclic path |p| and color black}
var @!t:pointer; {the new node}
begin t:=get_node(fill_node_size);
  type(t):=fill_code;
  path_p(t):=p;
  pen_p(t):=null; {|null| means don't use a pen}
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  @<Set the |ljoin_val| and |miterlim_val| fields in object |t|@>;
  new_fill_node:=t;
end;
@y
@ Let's consider the types of graphical objects one at a time.
First of all, a filled contour is represented by a eight-word node.  The first
word contains |type| and |link| fields, and the next six words contain a
pointer to a cyclic path and the value to use for \ps' \&{currentrgbcolor}
parameter.  If a pen is used for filling |pen_p|, |ljoin_val| and |miterlim_val|
give the relevant information.

@d path_p(#)==link(#+1)
  {a pointer to the path that needs filling}
@d pen_p(#)==info(#+1)
  {a pointer to the pen to fill or stroke with}
@d color_model(#)==type(#+2) { the color model }
@d obj_red_loc(#)==#+3  {the first of three locations for the color}
@d obj_cyan_loc==obj_red_loc  {the first of four locations for the color}
@d obj_grey_loc==obj_red_loc  {the location for the color}
@d red_val(#)==mem[#+3].sc
  {the red component of the color in the range $0\ldots1$}
@d cyan_val==red_val
@d grey_val==red_val
@d green_val(#)==mem[#+4].sc
  {the green component of the color in the range $0\ldots1$}
@d magenta_val==green_val
@d blue_val(#)==mem[#+5].sc
  {the blue component of the color in the range $0\ldots1$}
@d yellow_val==blue_val
@d black_val(#)==mem[#+6].sc
  {the blue component of the color in the range $0\ldots1$}
@d ljoin_val(#)==name_type(#)  {the value of \&{linejoin}}
@:linejoin_}{\&{linejoin} primitive@>
@d miterlim_val(#)==mem[#+7].sc  {the value of \&{miterlimit}}
@:miterlimit_}{\&{miterlimit} primitive@>
@d obj_color_part(#)==mem[#+3-red_part].sc
  {interpret an object pointer that has been offset by |red_part..blue_part|}
@d fill_node_size=8
@d fill_code=1

@p function new_fill_node(@!p: pointer): pointer;
  {make a fill node for cyclic path |p| and color black}
var @!t:pointer; {the new node}
begin t:=get_node(fill_node_size);
  type(t):=fill_code;
  path_p(t):=p;
  pen_p(t):=null; {|null| means don't use a pen}
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  black_val(t):=0;
  color_model(t):=uninitialized_model;
  @<Set the |ljoin_val| and |miterlim_val| fields in object |t|@>;
  new_fill_node:=t;
end;
@z

@x l. 8052
@ A stroked path is represented by an eight-word node that is like a filled
contour node except that it contains the current \&{linecap} value, a scale
factor for the dash pattern, and a pointer that is non-null if the stroke
is to be dashed.  The purpose of the scale factor is to allow a picture to
be transformed without touching the picture that |dash_p| points to.

@d dash_p(#)==link(#+6)
  {a pointer to the edge structure that gives the dash pattern}
@d lcap_val(#)==type(#+6)
  {the value of \&{linecap}}
@:linecap_}{\&{linecap} primitive@>
@d dash_scale(#)==mem[#+7].sc {dash lengths are scaled by this factor}
@d stroked_node_size=8
@d stroked_code=2

@p function new_stroked_node(@!p:pointer): pointer;
  {make a stroked node for path |p| with |pen_p(p)| temporarily |null|}
var @!t:pointer; {the new node}
begin t:=get_node(stroked_node_size);
  type(t):=stroked_code;
  path_p(t):=p; pen_p(t):=null;
  dash_p(t):=null;
  dash_scale(t):=unity;
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  @<Set the |ljoin_val| and |miterlim_val| fields in object |t|@>;
  if internal[linecap]>unity then lcap_val(t):=2
  else if internal[linecap]>0 then lcap_val(t):=1
  else lcap_val(t):=0;
  new_stroked_node:=t;
end;
@y
@ A stroked path is represented by an eight-word node that is like a filled
contour node except that it contains the current \&{linecap} value, a scale
factor for the dash pattern, and a pointer that is non-null if the stroke
is to be dashed.  The purpose of the scale factor is to allow a picture to
be transformed without touching the picture that |dash_p| points to.

@d dash_p(#)==link(#+8)
  {a pointer to the edge structure that gives the dash pattern}
@d lcap_val(#)==type(#+8)
  {the value of \&{linecap}}
@:linecap_}{\&{linecap} primitive@>
@d dash_scale(#)==mem[#+9].sc {dash lengths are scaled by this factor}
@d stroked_node_size=10
@d stroked_code=2

@p function new_stroked_node(@!p:pointer): pointer;
  {make a stroked node for path |p| with |pen_p(p)| temporarily |null|}
var @!t:pointer; {the new node}
begin t:=get_node(stroked_node_size);
  type(t):=stroked_code;
  path_p(t):=p; pen_p(t):=null;
  dash_p(t):=null;
  dash_scale(t):=unity;
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  black_val(t):=0;
  color_model(t):=uninitialized_model;
  @<Set the |ljoin_val| and |miterlim_val| fields in object |t|@>;
  if internal[linecap]>unity then lcap_val(t):=2
  else if internal[linecap]>0 then lcap_val(t):=1
  else lcap_val(t):=0;
  new_stroked_node:=t;
end;
@z

@x l. 8119
@ When a picture contains text, this is represented by a fourteen-word node
where the color information and |type| and |link| fields are augmented by
additional fields that describe the text and  how it is transformed.
The |path_p| and |pen_p| pointers are replaced by a number that identifies
the font and a string number that gives the text to be displayed.
The |width|, |height|, and |depth| fields
give the dimensions of the text at its design size, and the remaining six
words give a transformation to be applied to the text.  The |new_text_node|
function initializes everything to default values so that the text comes out
black with its reference point at the origin.

@d text_p(#)==link(#+1)  {a string pointer for the text to display}
@d font_n(#)==info(#+1)  {the font number}
@d width_val(#)==mem[#+5].sc  {unscaled width of the text}
@d height_val(#)==mem[#+6].sc  {unscaled height of the text}
@d depth_val(#)==mem[#+7].sc  {unscaled depth of the text}
@d text_tx_loc(#)==#+8
  {the first of six locations for transformation parameters}
@d tx_val(#)==mem[#+8].sc  {$x$ shift amount}
@d ty_val(#)==mem[#+9].sc  {$y$ shift amount}
@d txx_val(#)==mem[#+10].sc  {|txx| transformation parameter}
@d txy_val(#)==mem[#+11].sc  {|txy| transformation parameter}
@d tyx_val(#)==mem[#+12].sc  {|tyx| transformation parameter}
@d tyy_val(#)==mem[#+13].sc  {|tyy| transformation parameter}
@d text_trans_part(#)==mem[#+8-x_part].sc
    {interpret a text node ponter that has been offset by |x_part..yy_part|}
@d text_node_size=14
@d text_code=3

@p @<Declare text measuring subroutines@>@;
function new_text_node(f,s:str_number):pointer;
  {make a text node for font |f| and text string |s|}
var @!t:pointer; {the new node}
begin t:=get_node(text_node_size);
  type(t):=text_code;
  text_p(t):=s;
  font_n(t):=find_font(f); {this identifies the font}
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  tx_val(t):=0; ty_val(t):=0;
  txx_val(t):=unity; txy_val(t):=0;
  tyx_val(t):=0; tyy_val(t):=unity;
  set_text_box(t); {this finds the bounding box}
  new_text_node:=t;
end;
@y
@ When a picture contains text, this is represented by a fourteen-word node
where the color information and |type| and |link| fields are augmented by
additional fields that describe the text and  how it is transformed.
The |path_p| and |pen_p| pointers are replaced by a number that identifies
the font and a string number that gives the text to be displayed.
The |width|, |height|, and |depth| fields
give the dimensions of the text at its design size, and the remaining six
words give a transformation to be applied to the text.  The |new_text_node|
function initializes everything to default values so that the text comes out
black with its reference point at the origin.

@d text_p(#)==link(#+1)  {a string pointer for the text to display}
@d font_n(#)==info(#+1)  {the font number}
@d width_val(#)==mem[#+7].sc  {unscaled width of the text}
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
@d text_code=3

@p @<Declare text measuring subroutines@>@;
function new_text_node(f,s:str_number):pointer;
  {make a text node for font |f| and text string |s|}
var @!t:pointer; {the new node}
begin t:=get_node(text_node_size);
  type(t):=text_code;
  text_p(t):=s;
  font_n(t):=find_font(f); {this identifies the font}
  red_val(t):=0;
  green_val(t):=0;
  blue_val(t):=0;
  black_val(t):=0;
  color_model(t):=uninitialized_model;
  tx_val(t):=0; ty_val(t):=0;
  txx_val(t):=unity; txy_val(t):=0;
  tyx_val(t):=0; tyy_val(t):=unity;
  set_text_box(t); {this finds the bounding box}
  new_text_node:=t;
end;
@z

@x l. 8547
procedure print_obj_color(@!p:pointer);
begin if (red_val(p)>0) or (green_val(p)>0) or (blue_val(p)>0) then
  begin print("colored ");
  print_compact_node(obj_red_loc(p),3);
  end;
end;
@y
procedure print_obj_color(@!p:pointer);
begin if color_model(p)=grey_model then
    if grey_val(p)>0 then
      begin print("greyed ");
      print_compact_node(obj_grey_loc(p),1);
    end
  else if color_model(p)=cmyk_model then
    if (cyan_val(p)>0) or (magenta_val(p)>0) or (yellow_val(p)>0) or (black_val(p)>0) then
      begin print("colored ");
      print_compact_node(obj_cyan_loc(p),4);
    end
  else  if color_model(p)=rgb_model then
    if (red_val(p)>0) or (green_val(p)>0) or (blue_val(p)>0) then
      begin print("processcolored ");
      print_compact_node(obj_red_loc(p),3);
    end;
end;
@z

@x l. 8753
@ @<Make sure |p| and |p0| are the same color and |goto not_found|...@>=
if (red_val(p)<>red_val(p0)) or@|
  (green_val(p)<>green_val(p0)) or (blue_val(p)<>blue_val(p0)) then
@y
@ @<Make sure |p| and |p0| are the same color and |goto not_found|...@>=
if (red_val(p)<>red_val(p0)) or (black_val(p)<>black_val(p0)) or@|
  (green_val(p)<>green_val(p0)) or (blue_val(p)<>blue_val(p0)) then
@z

@x l. 14684
|cur_type=color_type| means that |cur_exp| points to a |color_type|
capsule node. The |value| part of this capsule
points to a color node that contains three numeric values,
each of which is |independent|, |dependent|, |proto_dependent|, or |known|.
@y
|cur_type=color_type| means that |cur_exp| points to a |color_type|
capsule node. The |value| part of this capsule
points to a color node that contains three numeric values,
each of which is |independent|, |dependent|, |proto_dependent|, or |known|.

\smallskip\hang
|cur_type=cmykcolor_type| means that |cur_exp| points to a |cmykcolor_type|
capsule node. The |value| part of this capsule
points to a color node that contains four numeric values,
each of which is |independent|, |dependent|, |proto_dependent|, or |known|.
@z

@x l. 14762
function stash_cur_exp:pointer;
var @!p:pointer; {the capsule that will be returned}
begin case cur_type of
unknown_types,transform_type,color_type,pair_type,dependent,proto_dependent,
  independent:p:=cur_exp;
@y
function stash_cur_exp:pointer;
var @!p:pointer; {the capsule that will be returned}
begin case cur_type of
unknown_types,transform_type,color_type,pair_type,dependent,proto_dependent,
  independent,cmykcolor_type:p:=cur_exp;
@z

@x l. 14795
procedure unstash_cur_exp(@!p:pointer);
begin cur_type:=type(p);
case cur_type of
unknown_types,transform_type,color_type,pair_type,dependent,proto_dependent,
  independent: cur_exp:=p;
@y
procedure unstash_cur_exp(@!p:pointer);
begin cur_type:=type(p);
case cur_type of
unknown_types,transform_type,color_type,pair_type,dependent,proto_dependent,
  independent,cmykcolor_type: cur_exp:=p;
@z

@x l. 14841
transform_type,color_type,pair_type:if v=null then print_type(t)
@y
transform_type,color_type,pair_type,cmykcolor_type:if v=null then print_type(t)
@z

@x l. 14925
procedure flush_cur_exp(@!v:scaled);
begin case cur_type of
unknown_types,transform_type,color_type,pair_type,@|
    dependent,proto_dependent,independent:
@y
procedure flush_cur_exp(@!v:scaled);
begin case cur_type of
unknown_types,transform_type,color_type,pair_type,@|
    dependent,proto_dependent,independent,cmykcolor_type:
@z

@xl. 14957
pair_type,color_type,transform_type:@<Recycle a big node@>;
@y
cmykcolor_type,pair_type,color_type,transform_type:@<Recycle a big node@>;
@z

@x l. 15256
begin l_delim:=cur_sym; r_delim:=cur_mod; get_x_next; scan_expression;
if (cur_cmd=comma) and (cur_type>=known) then
  @<Scan the rest of a pair or triplet of numerics@>
else check_delimiter(l_delim,r_delim);
@y
begin l_delim:=cur_sym; r_delim:=cur_mod; get_x_next; scan_expression;
if (cur_cmd=comma) and (cur_type>=known) then
  @<Scan the rest of a delimited set of numerics@>
else check_delimiter(l_delim,r_delim);
@z

@x l. 15298
@<Scan the rest of a pair or triplet of numerics@>=
begin p:=stash_cur_exp;
get_x_next; scan_expression;
@<Make sure the second part of a pair or color has a numeric type@>;
q:=get_node(value_node_size); name_type(q):=capsule;
if cur_cmd=comma then type(q):=color_type
else type(q):=pair_type;
init_big_node(q); r:=value(q);
stash_in(y_part_loc(r));
unstash_cur_exp(p);
stash_in(x_part_loc(r));
if cur_cmd=comma then @<Scan the last of a triplet of numerics@>;
check_delimiter(l_delim,r_delim);
cur_type:=type(q);
cur_exp:=q;
end
@y
@<Scan the rest of a delimited set of numerics@>=
begin p:=stash_cur_exp;
get_x_next; scan_expression;
@<Make sure the second part of a pair or color has a numeric type@>;
q:=get_node(value_node_size); name_type(q):=capsule;
if cur_cmd=comma then type(q):=color_type
else type(q):=pair_type;
init_big_node(q); r:=value(q);
stash_in(y_part_loc(r));
unstash_cur_exp(p);
stash_in(x_part_loc(r));
if cur_cmd=comma then @<Scan the last of a triplet of numerics@>;
if cur_cmd=comma then begin 
  type(q):=cmykcolor_type;
  init_big_node(q); t:=value(q);
  mem[cyan_part_loc(t)]:=mem[red_part_loc(r)];
  value(cyan_part_loc(t)):=value(red_part_loc(r));
  mem[magenta_part_loc(t)]:=mem[green_part_loc(r)];
  value(magenta_part_loc(t)):=value(green_part_loc(r));
  mem[yellow_part_loc(t)]:=mem[blue_part_loc(r)];
  value(yellow_part_loc(t)):=value(blue_part_loc(r));
  recycle_value(r);
  r:=t;
  @<Scan the last of a quartet of numerics@>;
  end;
check_delimiter(l_delim,r_delim);
cur_type:=type(q);
cur_exp:=q;
end
@z

@x l. 15315
@ @<Make sure the second part of a pair or color has a numeric type@>=
if cur_type<known then
  begin exp_err("Nonnumeric ypart has been replaced by 0");
@.Nonnumeric...replaced by 0@>
  help4("I've started to scan a pair `(a,b)' or a color `(a,b,c)';")@/
    ("but after finding a nice `a' I found a `b' that isn't")@/
    ("of numeric type. So I've changed that part to zero.")@/
    ("(The b that I didn't like appears above the error message.)");
  put_get_flush_error(0);
  end
@y
@ @<Make sure the second part of a pair or color has a numeric type@>=
if cur_type<known then
  begin exp_err("Nonnumeric ypart has been replaced by 0");
@.Nonnumeric...replaced by 0@>
  help4("I've started to scan a pair `(a,b)' or a color `(a,b,c)';")@/
    ("but after finding a nice `a' I found a `b' that isn't")@/
    ("of numeric type. So I've changed that part to zero.")@/
    ("(The b that I didn't like appears above the error message.)");
  put_get_flush_error(0);
  end
@z

@x l. 15326
@ @<Scan the last of a triplet of numerics@>=
begin get_x_next; scan_expression;
if cur_type<known then
  begin exp_err("Nonnumeric bluepart has been replaced by 0");
@.Nonnumeric...replaced by 0@>
  help3("I've just scanned a color `(r,g,b)'; but the `b' isn't")@/
    ("of numeric type. So I've changed that part to zero.")@/
    ("(The b that I didn't like appears above the error message.)");@/
  put_get_flush_error(0);
  end;
stash_in(blue_part_loc(r));
end
@y
@ @<Scan the last of a triplet of numerics@>=
begin get_x_next; scan_expression;
if cur_type<known then
  begin exp_err("Nonnumeric third part has been replaced by 0");
@.Nonnumeric...replaced by 0@>
  help3("I've just scanned a color `(a,b,c)' or cmykcolor(a,b,c,d); but the `c' isn't")@/
    ("of numeric type. So I've changed that part to zero.")@/
    ("(The c that I didn't like appears above the error message.)");@/
  put_get_flush_error(0);
  end;
stash_in(blue_part_loc(r));
end

@ @<Scan the last of a quartet of numerics@>=
begin get_x_next; scan_expression;
if cur_type<known then
  begin exp_err("Nonnumeric blackpart has been replaced by 0");
@.Nonnumeric...replaced by 0@>
  help3("I've just scanned a cmykcolor `(c,m,y,k)'; but the `k' isn't")@/
    ("of numeric type. So I've changed that part to zero.")@/
    ("(The k that I didn't like appears above the error message.)");@/
  put_get_flush_error(0);
  end;
stash_in(black_part_loc(r));
end
@z

@x l. 15667
transform_type,color_type,pair_type:@<Copy the big node |p|@>;
@y
transform_type,color_type,cmykcolor_type,pair_type:@<Copy the big node |p|@>;
@z

@x l. 16366
primitive("redpart",unary,red_part);@/
@!@:red_part_}{\&{redpart} primitive@>
primitive("greenpart",unary,green_part);@/
@!@:green_part_}{\&{greenpart} primitive@>
primitive("bluepart",unary,blue_part);@/
@!@:blue_part_}{\&{bluepart} primitive@>
@y
primitive("redpart",unary,red_part);@/
@!@:red_part_}{\&{redpart} primitive@>
primitive("greenpart",unary,green_part);@/
@!@:green_part_}{\&{greenpart} primitive@>
primitive("bluepart",unary,blue_part);@/
@!@:blue_part_}{\&{bluepart} primitive@>
primitive("cyanpart",unary,cyan_part);@/
@!@:cyan_part_}{\&{cyanpart} primitive@>
primitive("magentapart",unary,magenta_part);@/
@!@:magenta_part_}{\&{magentapart} primitive@>
primitive("yellowpart",unary,yellow_part);@/
@!@:yellow_part_}{\&{yellowpart} primitive@>
primitive("blackpart",unary,black_part);@/
@!@:black_part_}{\&{blackpart} primitive@>
primitive("greypart",unary,grey_part);@/
@!@:grey_part_}{\&{greypart} primitive@>
primitive("colormodel",unary,color_model_part);@/
@!@:color_model_part_}{\&{colormodel} primitive@>
@z


@x l. 16580
function nice_color_or_pair(@!p:integer;@!t:quarterword):boolean;
label exit;
var @!q,@!r:pointer; {for scanning the big node}
begin if (t<>pair_type)and(t<>color_type) then
@y
function nice_color_or_pair(@!p:integer;@!t:quarterword):boolean;
label exit;
var @!q,@!r:pointer; {for scanning the big node}
begin if (t<>pair_type)and(t<>color_type)and(t<>cmykcolor_type) then
@z

@x l. 16597
procedure print_known_or_unknown_type(@!t:small_number;@!v:integer);
begin print_char("(");
if t>known then print("unknown numeric")
else begin if (t=pair_type)or(t=color_type) then
@y
procedure print_known_or_unknown_type(@!t:small_number;@!v:integer);
begin print_char("(");
if t>known then print("unknown numeric")
else begin if (t=pair_type)or(t=color_type)or(t=cmykcolor_type) then
@z

@x  l. 16637
@<Negate the current expression@>=
case cur_type of
color_type,pair_type,independent: begin q:=cur_exp; make_exp_copy(q);
@y
@<Negate the current expression@>=
case cur_type of
color_type,cmykcolor_type,pair_type,independent: begin 
  q:=cur_exp; make_exp_copy(q);
@z

@x l. 16717
red_part,green_part,blue_part: if cur_type=color_type then take_part(c)
  else if cur_type=picture_type then take_pict_part(c)
  else bad_unary(c);
@y
red_part,green_part,blue_part: if cur_type=color_type then take_part(c)
  else if cur_type=picture_type then take_pict_part(c)
  else bad_unary(c);
cyan_part,magenta_part,yellow_part,black_part: if cur_type=cmykcolor_type 
  then take_part(c) else if cur_type=picture_type then take_pict_part(c)
  else bad_unary(c);
grey_part: if cur_type=known then cur_exp:=value(c)
  else if cur_type=picture_type then take_pict_part(c)
  else bad_unary(c);
color_model_part: if cur_type=picture_type then take_pict_part(c)
  else bad_unary(c);
@z

@x l. 16752
    red_part,green_part,blue_part:
      if has_color(p) then flush_cur_exp(obj_color_part(p+c))
      else goto not_found;
@y
    red_part,green_part,blue_part:
      if has_color(p) then flush_cur_exp(obj_color_part(p+c))
      else goto not_found;
    cyan_part,magenta_part,yellow_part,black_part:
      if has_color(p) then 
        if color_model(p)=uninitialized_model then
          flush_cur_exp(unity)
        else 
          flush_cur_exp(obj_color_part(p+c+(red_part-cyan_part)))
      else goto not_found;
    grey_part:
      if has_color(p) then 
          flush_cur_exp(obj_color_part(p+c+(red_part-grey_part)))
      else goto not_found;
    color_model_part:
      if has_color(p) then 
        if color_model(p)=uninitialized_model then
          flush_cur_exp(internal[default_color_model])
        else
          flush_cur_exp(color_model(p)*unity)
      else goto not_found;
@z


@x  l. 17058
transform_type,color_type,pair_type: type_test(c);
@y
transform_type,color_type,cmykcolor_type,pair_type: type_test(c);
@z

@x l. 17071
transform_type,color_type,pair_type:begin p:=value(cur_exp);
@y
transform_type,color_type,cmykcolor_type,pair_type:begin p:=value(cur_exp);
@z

@x l. 17323
@<Sidestep |independent| cases in capsule |p|@>=
case type(p) of
transform_type,color_type,pair_type: old_p:=tarnished(p);
@y
@<Sidestep |independent| cases in capsule |p|@>=
case type(p) of
transform_type,color_type,cmykcolor_type,pair_type: old_p:=tarnished(p);
@z

@x l. 17334
@ @<Sidestep |independent| cases in the current expression@>=
case cur_type of
transform_type,color_type,pair_type:old_exp:=tarnished(cur_exp);
@y
@ @<Sidestep |independent| cases in the current expression@>=
case cur_type of
transform_type,color_type,cmykcolor_type,
pair_type:old_exp:=tarnished(cur_exp);
@z

@x l. 17557
@ @<Multiply when at least one operand is known@>=
begin if type(p)=known then
  begin v:=value(p); free_node(p,value_node_size);
  end
else  begin v:=cur_exp; unstash_cur_exp(p);
  end;
if cur_type=known then cur_exp:=take_scaled(cur_exp,v)
else if (cur_type=pair_type)or(cur_type=color_type) then
@y
@ @<Multiply when at least one operand is known@>=
begin if type(p)=known then
  begin v:=value(p); free_node(p,value_node_size);
  end
else  begin v:=cur_exp; unstash_cur_exp(p);
  end;
if cur_type=known then cur_exp:=take_scaled(cur_exp,v)
else if (cur_type=pair_type)or(cur_type=color_type)or
          (cur_type=cmykcolor_type) then
@z

@x l. 17602
transform_type,color_type,pair_type:old_exp:=tarnished(cur_exp);
@y
transform_type,color_type,cmykcolor_type,pair_type:old_exp:=tarnished(cur_exp);
@z

@x l. 18649
transform_type,color_type,pair_type:if cur_type=t then
    @<Do multiple equations and |goto done|@>;
@y
transform_type,color_type,cmykcolor_type,
pair_type:if cur_type=t then
    @<Do multiple equations and |goto done|@>;
@z

@x l. 18834
primitive("color",type_name,color_type);@/
@!@:color_}{\&{color} primitive@>
@y
primitive("color",type_name,color_type);@/
@!@:color_}{\&{color} primitive@>
primitive("rgbcolor",type_name,color_type);@/
@!@:color_}{\&{rgbcolor} primitive@>
primitive("cmykcolor",type_name,cmykcolor_type);@/
@!@:color_}{\&{cmykcolor} primitive@>
@z

@x l. 19337
primitive("withcolor",with_option,color_type);@/
@!@:with_color_}{\&{withcolor} primitive@>
@y
primitive("withoutcolor",with_option,no_model);@/
@!@:with_color_}{\&{withoutcolor} primitive@>
primitive("withgreyscale",with_option,grey_model);@/
@!@:with_color_}{\&{withgreyscale} primitive@>
primitive("withcolor",with_option,uninitialized_model);@/
@!@:with_color_}{\&{withcolor} primitive@>
{ \&{withrgbcolor} is an alias for \&{withcolor}}
primitive("withrgbcolor",with_option,rgb_model);@/
@!@:with_color_}{\&{withrgbcolor} primitive@>
primitive("withcmykcolor",with_option,cmyk_model);@/
@!@:with_color_}{\&{withcmykcolor} primitive@>
@z

@x l. 19344
with_option:if m=pen_type then print("withpen")
  else if m=color_type then print("withcolor")
  else print("dashed");
@y
with_option:if m=pen_type then print("withpen")
  else if m=no_model then print("withoutcolor")
  else if m=rgb_model then print("withrgbcolor")
  else if m=uninitialized_model then print("withcolor") 
  else if m=cmyk_model then print("withcmykcolor")
  else if m=grey_model then print("withgreyscale")
  else print("dashed");
@z

@x l. 19363
  begin t:=cur_mod; get_x_next; scan_expression;
  if cur_type<>t then @<Complain about improper type@>
  else if t=color_type then
      begin if cp=void then @<Make |cp| a colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a color from the current expression to object~|cp|@>;
      flush_cur_exp(0);
      end
@y
  begin t:=cur_mod; 
  get_x_next; 
  if t<>no_model then scan_expression;
  if ((t=uninitialized_model)and
        ((cur_type<>cmykcolor_type)and(cur_type<>color_type)
          and(cur_type<>known)and(cur_type<>boolean_type)))or
     ((t=cmyk_model)and(cur_type<>cmykcolor_type))or
     ((t=rgb_model)and(cur_type<>color_type))or
     ((t=grey_model)and(cur_type<>known))or
     ((t=pen_type)and(cur_type<>t))or
     ((t=picture_type)and(cur_type<>t)) then @<Complain about improper type@>
  else if t=uninitialized_model then
      begin if cp=void then @<Make |cp| a colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a color from the current expression to object~|cp|@>;
      flush_cur_exp(0);
      end
  else if t=rgb_model then
      begin if cp=void then @<Make |cp| a rgb colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a rgbcolor from the current expression to object~|cp|@>;
      flush_cur_exp(0);
      end
  else if t=cmyk_model then
      begin if cp=void then @<Make |cp| a cmyk colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a cmykcolor from the current expression to object~|cp|@>;
      flush_cur_exp(0);
      end
  else if t=grey_model then
      begin if cp=void then @<Make |cp| a grey colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a greyscale from the current expression to object~|cp|@>;
      flush_cur_exp(0);
      end
  else if t=no_model then
      begin if cp=void then @<Make |cp| a no colored object in object list~|p|@>;
      if cp<>null then
        @<Transfer a noncolor from the current expression to object~|cp|@>;
      end
@z

@x l. 19398
else if t=color_type then
  help_line[1]:="Next time say `withcolor <known color expression>';";
@y
else if t=uninitialized_model then
  help_line[1]:="Next time say `withcolor <known color expression>';"
else if t=rgb_model then
  help_line[1]:="Next time say `withrgbcolor <known color expression>';"
else if t=cmyk_model then
  help_line[1]:="Next time say `withcmykcolor <known cmykcolor expression>';"
else if t=grey_model then
  help_line[1]:="Next time say `withgreyscale <known numeric expression>';";
@z

@x l. 19406
@<Transfer a color from the current expression to object~|cp|@>=
begin q:=value(cur_exp);
red_val(cp):=value(red_part_loc(q));
green_val(cp):=value(green_part_loc(q));
blue_val(cp):=value(blue_part_loc(q));@/
if red_val(cp)<0 then red_val(cp):=0;
if green_val(cp)<0 then green_val(cp):=0;
if blue_val(cp)<0 then blue_val(cp):=0;
if red_val(cp)>unity then red_val(cp):=unity;
if green_val(cp)>unity then green_val(cp):=unity;
if blue_val(cp)>unity then blue_val(cp):=unity;
end
@y
@<Transfer a color from the current expression to object~|cp|@>=
begin if cur_type=color_type then
   @<Transfer a rgbcolor from the current expression to object~|cp|@>
else if cur_type=cmykcolor_type then
   @<Transfer a cmykcolor from the current expression to object~|cp|@>
else if cur_type=known then
   @<Transfer a greyscale from the current expression to object~|cp|@>
else if cur_exp=false_code then
   @<Transfer a noncolor from the current expression to object~|cp|@>;
end

@ @<Transfer a rgbcolor from the current expression to object~|cp|@>=
begin q:=value(cur_exp);
cyan_val(cp):=0;
magenta_val(cp):=0;
yellow_val(cp):=0;
black_val(cp):=0;
red_val(cp):=value(red_part_loc(q));
green_val(cp):=value(green_part_loc(q));
blue_val(cp):=value(blue_part_loc(q));@/
color_model(cp):=rgb_model;
if red_val(cp)<0 then red_val(cp):=0;
if green_val(cp)<0 then green_val(cp):=0;
if blue_val(cp)<0 then blue_val(cp):=0;
if red_val(cp)>unity then red_val(cp):=unity;
if green_val(cp)>unity then green_val(cp):=unity;
if blue_val(cp)>unity then blue_val(cp):=unity;
end

@ @<Transfer a cmykcolor from the current expression to object~|cp|@>=
begin q:=value(cur_exp);
cyan_val(cp):=value(cyan_part_loc(q));
magenta_val(cp):=value(magenta_part_loc(q));
yellow_val(cp):=value(yellow_part_loc(q));@/
black_val(cp):=value(black_part_loc(q));@/
color_model(cp):=cmyk_model;
if cyan_val(cp)<0 then cyan_val(cp):=0;
if magenta_val(cp)<0 then magenta_val(cp):=0;
if yellow_val(cp)<0 then yellow_val(cp):=0;
if black_val(cp)<0 then black_val(cp):=0;
if cyan_val(cp)>unity then cyan_val(cp):=unity;
if magenta_val(cp)>unity then magenta_val(cp):=unity;
if yellow_val(cp)>unity then yellow_val(cp):=unity;
if black_val(cp)>unity then black_val(cp):=unity;
end

@ @<Transfer a greyscale from the current expression to object~|cp|@>=
begin q:=cur_exp;
cyan_val(cp):=0;
magenta_val(cp):=0;
yellow_val(cp):=0;
black_val(cp):=0;
grey_val(cp):=q;
color_model(cp):=grey_model;
if grey_val(cp)<0 then grey_val(cp):=0;
if grey_val(cp)>unity then grey_val(cp):=unity;
end

@ @<Transfer a noncolor from the current expression to object~|cp|@>=
begin 
cyan_val(cp):=0;
magenta_val(cp):=0;
yellow_val(cp):=0;
black_val(cp):=0;
grey_val(cp):=0;
color_model(cp):=no_model;
end
@z

@x l. 19419
@ @<Make |cp| a colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done;
  cp:=link(cp);
  end;
done:do_nothing;
end
@y
@ It is a bit silly to repeat this action in five different
forms with the only difference being the label. Ah well.

@<Make |cp| a colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done;
  cp:=link(cp);
  end;
done:do_nothing;
end

@ @<Make |cp| a rgb colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done6;
  cp:=link(cp);
  end;
done6:do_nothing;
end

@ @<Make |cp| a cmyk colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done5;
  cp:=link(cp);
  end;
done5:do_nothing;
end

@ @<Make |cp| a grey colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done4;
  cp:=link(cp);
  end;
done4:do_nothing;
end

@ @<Make |cp| a no colored object in object list~|p|@>=
begin cp:=p;
while cp<>null do
  begin if has_color(cp) then goto done3;
  cp:=link(cp);
  end;
done3:do_nothing;
end
@z

@x l. 19446
@ @<Copy the information from objects |cp|, |pp|, and |dp| into...@>=
if cp>void then @<Copy |cp|'s color into the colored objects linked to~|cp|@>;
@y
@ @<Copy the information from objects |cp|, |pp|, and |dp| into...@>=
@<Copy |cp|'s color into the colored objects linked to~|cp|@>;
@z

@x l. 19452
@ @<Copy |cp|'s color into the colored objects linked to~|cp|@>=
begin q:=link(cp);
while q<>null do
  begin if has_color(q) then
    begin red_val(q):=red_val(cp);
    green_val(q):=green_val(cp);
    blue_val(q):=blue_val(cp);@/
    end;
  q:=link(q);
  end;
end
@y
@ @<Copy |cp|'s color into the colored objects linked to~|cp|@>=
begin q:=link(cp);
while q<>null do
  begin if has_color(q) then
    begin red_val(q):=red_val(cp);
    green_val(q):=green_val(cp);
    blue_val(q):=blue_val(cp);@/
    black_val(q):=black_val(cp);@/
    color_model(q):=color_model(cp);@/
    end;
  q:=link(q);
  end;
end
@z

@x l. 21570
@!gs_red,@!gs_green,@!gs_blue:scaled;
 {color from the last \&{setrgbcolor} or \&{setgray} command}
@:setrgbcolor}{\&{setrgbcolor} command@>
@:setgray}{\&{setgray} command@>
@y
@!gs_red,@!gs_green,@!gs_blue,@!gs_black:scaled;
 {color from the last \&{setcmykcolor} or \&{setrgbcolor} or \&{setgray} command}
@:setcmykcolor}{\&{setcmykcolor} command@>
@:setrgbcolor}{\&{setrgbcolor} command@>
@:setgray}{\&{setgray} command@>
@!gs_colormodel:quarterword; { the current colormodel }
@z


@x
@ To avoid making undue assumptions about the initial graphics state, these
parameters are given special values that are guaranteed not to match anything
in the edge structure being shipped out.  On the other hand, the initial color
should be black so that the translation of an all-black picture will have no
\&{setcolor} commands.  (These would be undesirable in a font application.)
Hence we use |c=0| when initializing the graphics state and we use |c<0|
to recover from a situation where we have lost track of the graphics state.

@<Declare the \ps\ output procedures@>=
procedure unknown_graphics_state(c:scaled);
begin gs_red:=c; gs_green:=c; gs_blue:=c;@/
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
begin gs_red:=c; gs_green:=c; gs_blue:=c; gs_black:=c;@/
gs_colormodel:=uninitialized_model;
gs_ljoin:=3;
gs_lcap:=3;
gs_miterlim:=0;@/
gs_dash_p:=void;
gs_dash_sc:=0;
gs_width:=-1;
end;
@z

@x l. 21656
@ @<Make sure \ps\ will use the right color for object~|p|@>=
if (gs_red<>red_val(p))or(gs_green<>green_val(p))or@|
    (gs_blue<>blue_val(p)) then
  begin gs_red:=red_val(p);
  gs_green:=green_val(p);
  gs_blue:=blue_val(p);@/
  if (gs_red=gs_green)and(gs_green=gs_blue) then
    begin ps_room(16);
    print_char(" ");
    print_scaled(gs_red);
    print(" setgray");
    end
  else begin ps_room(36);
    print_char(" ");
    print_scaled(gs_red); print_char(" ");
    print_scaled(gs_green); print_char(" ");
    print_scaled(gs_blue);
    print(" setrgbcolor");
    end;
  end;
@y
@ @<Make sure \ps\ will use the right color for object~|p|@>=
begin
  if (color_model(p)=rgb_model)or@|
     ((color_model(p)=uninitialized_model)and
     ((internal[default_color_model] div unity)=rgb_model)) then
  begin if (gs_colormodel<>rgb_model)or(gs_red<>red_val(p))or@|
      (gs_green<>green_val(p))or(gs_blue<>blue_val(p)) then
    begin gs_red:=red_val(p);
      gs_green:=green_val(p);
      gs_blue:=blue_val(p);
      gs_black:= -1;@/
      gs_colormodel:=rgb_model;
      begin ps_room(36);
        print_char(" ");
        print_scaled(gs_red); print_char(" ");
        print_scaled(gs_green); print_char(" ");
        print_scaled(gs_blue);
        print(" setrgbcolor");
        end;
      end;
    end
  else if (color_model(p)=cmyk_model)or@|
     ((color_model(p)=uninitialized_model)and
     ((internal[default_color_model] div unity)=cmyk_model)) then
  begin if (gs_red<>cyan_val(p))or(gs_green<>magenta_val(p))or@|
      (gs_blue<>yellow_val(p))or(gs_black<>black_val(p))or@|
      (gs_colormodel<>cmyk_model) then
      begin 
      if color_model(p)=uninitialized_model then begin
        gs_red:=unity;
        gs_green:=unity;
        gs_blue:=unity;
        gs_black:=unity;@/
        end
      else begin
        gs_red:=cyan_val(p);
        gs_green:=magenta_val(p);
        gs_blue:=yellow_val(p);
        gs_black:=black_val(p);@/
        end;
      gs_colormodel:=cmyk_model;
      begin ps_room(45);
        print_char(" ");
        print_scaled(gs_red); print_char(" ");
        print_scaled(gs_green); print_char(" ");
        print_scaled(gs_blue); print_char(" ");
        print_scaled(gs_black);
        print(" setcmykcolor");
        end;
      end;
    end    
  else if (color_model(p)=grey_model)or@|
    ((color_model(p)=uninitialized_model)and
     ((internal[default_color_model] div unity)=grey_model)) then
  begin if (gs_red<>grey_val(p))or(gs_colormodel<>grey_model) then
    begin gs_red := grey_val(p);
      gs_green:= -1;
      gs_blue:= -1;
      gs_black:= -1;@/
      gs_colormodel:=grey_model;
      begin ps_room(16);
        print_char(" ");
        print_scaled(gs_red); 
        print(" setgray");
        end;
      end;
    end;
  if color_model(p)=no_model then
    gs_colormodel:=no_model;
end
@z
