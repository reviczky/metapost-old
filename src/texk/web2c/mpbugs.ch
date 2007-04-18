% $Id$
%
% fix the turningnumber command, and remove emergency_line_length test

@x l. 16993
@ The turning number is computed only with respect to a triangular pen whose
@:turning_number_}{\&{turningnumber} primitive@>
vertices are $(0,1)$ and $(\pm{1\over2},0)$.  The choice of pen isn't supposed
to matter but rounding error could make a difference if the path has a cusp.

@<Additional cases of unary...@>=
turning_op:if cur_type=pair_type then flush_cur_exp(0)
  else if cur_type<>path_type then bad_unary(turning_op)
  else if left_type(cur_exp)=endpoint then
     flush_cur_exp(0) {not a cyclic path}
  else  begin
    flush_cur_exp(turn_cycles(cur_exp));
    end;
@y
@ Implement |turningnumber|

@<Additional cases of unary...@>=
turning_op:if cur_type=pair_type then flush_cur_exp(0)
  else if cur_type<>path_type then bad_unary(turning_op)
  else if left_type(cur_exp)=endpoint then
     flush_cur_exp(0) {not a cyclic path}
  else  begin
    flush_cur_exp(turn_cycles_wrapper(cur_exp));
    end;

@ The function |new_an_angle| returns the value of the |angle| primitive, or $0$ if the 
argument is |origin|. 

@<Declare unary action...@>=
function new_an_angle (@!xpar,@!ypar:scaled):angle;
begin
  if (not ((xpar=0) and (ypar=0))) then
    new_an_angle := n_arg(xpar,ypar)
  else
    new_an_angle := 0;
end;


@ The actual turning number is (for the moment) computed in a C function
that receives eight integers corresponding to the four controlling points,
and returns a single angle.  Besides those, we have to account for discrete 
moves at the actual points.

@d p_nextnext==link(link(p))
@d p_next==link(p)

@d seven_twenty_deg==@'5500000000 {$720\cdot2^{20}$, represents $720^\circ$}

@<Declare unary action...@>=
function new_turn_cycles (@!c:pointer):scaled;
label exit;
var @!res,ang:angle; { the angles of intermediate results }
@!turns:scaled;  { the turn counter }
@!p:pointer;     { for running around the path }
@!xp,yp:integer;   { coordinates of next point }
@!x,y:integer;   { helper coordinates }
@!in_angle,out_angle:angle;     { helper angles}
@!old_setting:0..max_selector; {saved |selector| setting}
begin  
res:=0;
turns:= 0;
p:=c;
old_setting := selector; selector:=term_only;
if internal[tracing_commands]>unity then begin
  begin_diagnostic; 
  print_nl("");
  end_diagnostic(false);
end;
if (p_next=p)or(p_nextnext=p) then
  if new_an_angle (x_coord(p) - right_x(p),  y_coord(p) - right_y(p)) >= 0 then
     new_turn_cycles := unity
  else
     new_turn_cycles := -unity
else begin
  repeat
    xp := x_coord(p_next); yp := y_coord(p_next);
    ang  := bezier_slope(x_coord(p), y_coord(p), right_x(p), right_y(p),  
                        left_x(p_next), left_y(p_next), xp, yp, internal[tracing_commands]);
    if ang>seven_twenty_deg then begin
      print_err("Strange path");
      error;
      new_turn_cycles := 0;
      return;
      end;
    res  := res + ang;
    if res >= one_eighty_deg then begin
      res := res - three_sixty_deg;
      turns := turns + unity;
    end;
    if res <= -one_eighty_deg then begin
      res := res + three_sixty_deg;
      turns := turns - unity;
    end;
    { incoming angle at next point }
    x := left_x(p_next);  y := left_y(p_next);
    if (xp=x)and(yp=y) then begin x := right_x(p);  y := right_y(p);  end;
    if (xp=x)and(yp=y) then begin x := x_coord(p);  y := y_coord(p);  end;
    in_angle := new_an_angle(xp - x, yp - y);
    { outgoing angle at next point }
    x := right_x(p_next);  y := right_y(p_next);
    if (xp=x)and(yp=y) then begin x := left_x(p_nextnext);  y := left_y(p_nextnext);  end;
    if (xp=x)and(yp=y) then begin x := x_coord(p_nextnext); y := y_coord(p_nextnext); end;
    out_angle := new_an_angle(x - xp, y- yp);
    ang  := (out_angle - in_angle);
    if (ang<>0)and(abs(ang)<=one_eighty_deg) then begin
      res  := res + ang;	
      if res >= one_eighty_deg then begin
        res := res - three_sixty_deg;
        turns := turns + unity;
      end;
      if res <= -one_eighty_deg then begin
        res := res + three_sixty_deg;
        turns := turns - unity;
      end;
    end;
    p := link(p);
  until p=c;
  new_turn_cycles := turns;
end;
exit:
selector:=old_setting;
end;
@z

@x
function count_turns(@!c:pointer):scaled;
@y
function turn_cycles_wrapper (@!c:pointer):scaled;
  var nval,oval:scaled;
  saved_t_o:scaled; {tracing_online saved }
begin 
   nval := new_turn_cycles(c);
   oval := turn_cycles(c);
   if nval<>oval then begin
     saved_t_o:=internal[tracing_online];
     internal[tracing_online]:=unity;
     begin_diagnostic;
     print   ("Warning: The turningnumber algorithms do not agree. The current computed value is ");
     print_scaled(nval);
     print(", but the 'connect-the-dots' algorithm returned ");
     print_scaled(oval);     
     end_diagnostic(false);
     internal[tracing_online]:=saved_t_o;
   end;
   turn_cycles_wrapper := nval;
end;

@ @<Declare unary action...@>=
function count_turns(@!c:pointer):scaled;
@z


@x l. 22256
@ @<Print any pending specials@>=
t:=link(spec_head);
while t<>null do
  begin if length(value(t))<=emergency_line_length then print(value(t))
  else overflow("output line length",emergency_line_length);
@:MetaPost capacity exceeded output line length}{\quad output line length@>
  print_ln;
  t:=link(t);
  end;
flush_token_list(link(spec_head));
link(spec_head):=null;
last_pending:=spec_head
@y
@ @<Print any pending specials@>=
t:=link(spec_head);
while t<>null do
  begin  print(value(t));
  print_ln;
  t:=link(t);
  end;
flush_token_list(link(spec_head));
link(spec_head):=null;
last_pending:=spec_head
@z
