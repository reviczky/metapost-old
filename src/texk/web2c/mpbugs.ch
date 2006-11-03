% $Id$
%
% fix the turningnumber command

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


@ This code is based on Bogus\l{}av Jackowski's
|emergency_turningnumber| macro, with some minor changes by Taco
Hoekwater. The macro code looked more like this:
{\obeylines
vardef turning\_number primary p =
~~save res, ang, turns;
~~res := 0;
~~if length p <= 2:
~~~~if Angle ((point 0 of p) - (postcontrol 0 of p)) >= 0:  1  else: -1 fi
~~else:
~~~~for t = 0 upto length p-1 :
~~~~~~angc := Angle ((point t+1 of p)  - (point t of p))
~~~~~~~~- Angle ((point t of p) - (point t-1 of p));
~~~~~~if angc > 180: angc := angc - 360; fi;
~~~~~~if angc < -180: angc := angc + 360; fi;
~~~~~~res  := res + angc;
~~~~endfor;
~~res/360
~~fi
enddef;}
The general idea is to calculate only the sum of the angles of straight lines between
the points, of a path, not worrying about cusps or self-intersections in the segments
at all. If the segment is not well-behaved, the result is not necesarily correct. But
the old code was not always correct either, and worse, it sometimes failed for well-behaved
paths as well. All known bugs that were triggered by the original code no longer occur
with this code, and it runs roughly 3 times as fast because the algorithm is much simpler.

@ The macro |Angle()| returns the value of the |angle| primitive, or $0$ if the argument is
|origin|. Converting that calling convention to web code gives the |an_angle| function.

@<Declare unary action...@>=
function an_angle (@!xpar,@!ypar:scaled):angle;
begin
  if (not ((xpar=0) and (ypar=0))) then
    an_angle := n_arg(xpar,ypar)
  else
    an_angle := 0;
end;


@ It is possible to overflow the return value of the |turn_cycles|
function when the path is sufficiently long and winding, but I am not
going to bother testing for that. In any case, it would only return
the looped result value, which is not a big problem.

The macro code for the repeat loop was a bit nicer to look
at than the pascal code, because it could use |point -1 of p|. In
pascal, the fastest way to loop around the path is not to look
backward once, but forward twice. These defines help hide the trick.

@d p_to==link(link(p))
@d p_here==link(p)
@d p_from==p

@<Declare unary action...@>=
function turn_cycles (@!c:pointer):scaled;
var @!res,ang:angle; { the angles of intermediate results }
@!turns:scaled;  { the turn counter }
@!p:pointer;     { for running around the path }
begin  res:=0;  turns:= 0; p:=c;
if ((link(p) = p) or (link(link(p)) = p)) then
  if an_angle (x_coord(p) - right_x(p),  y_coord(p) - right_y(p)) >= 0 then
     turn_cycles := unity
  else
     turn_cycles := -unity
else begin
  repeat
    ang  := an_angle (x_coord(p_to) - x_coord(p_here), y_coord(p_to) - y_coord(p_here))
      	- an_angle (x_coord(p_here) - x_coord(p_from), y_coord(p_here) - y_coord(p_from));
    reduce_angle(ang);
    res  := res + ang;
    if res >= three_sixty_deg then  begin
      res := res - three_sixty_deg;
      turns := turns + unity;
    end;
    if res <= -three_sixty_deg then begin
      res := res + three_sixty_deg;
      turns := turns - unity;
    end;
    p := link(p);
  until p=c;
  turn_cycles := turns;
end;
end;

@ @<Declare unary action...@>=
function count_turns(@!c:pointer):scaled;
var @!p:pointer; {a knot in envelope spec |c|}
@!t:integer; {total pen offset changes counted}
begin t:=0; p:=c;
repeat t:=t+info(p)-zero_off;
p:=link(p);
until p=c;
count_turns:=(t div 3)*unity;
end;
@y
@ Implement |turningnumber|

@<Additional cases of unary...@>=
turning_op:if cur_type=pair_type then flush_cur_exp(0)
  else if cur_type<>path_type then bad_unary(turning_op)
  else if left_type(cur_exp)=endpoint then
     flush_cur_exp(0) {not a cyclic path}
  else  begin
    flush_cur_exp(turn_cycles(cur_exp));
    end;

@ The function |an_angle| returns the value of the |angle| primitive, or $0$ if the 
argument is |origin|. 

@<Declare unary action...@>=
function an_angle (@!xpar,@!ypar:scaled):angle;
begin
  if (not ((xpar=0) and (ypar=0))) then
    an_angle := n_arg(xpar,ypar)
  else
    an_angle := 0;
end;


@ The actual turning number is (for the moment) computed in a C function
that receives eight integers corresponding to the four controlling points,
and returns a single angle.  Besides those, we have to account for discrete 
moves at the actual points.

@d p_nextnext==link(link(p))
@d p_next==link(p)

@d seven_twenty_deg==@'5500000000 {$720\cdot2^{20}$, represents $720^\circ$}

@<Declare unary action...@>=
function turn_cycles (@!c:pointer):scaled;
label exit;
var @!res,ang:angle; { the angles of intermediate results }
@!turns:scaled;  { the turn counter }
@!p:pointer;     { for running around the path }
@!xp,yp:integer;   { coordinates of next point }
@!x,y:integer;   { helper coordinates }
@!in_angle,out_angle:angle;     { helper angles}
begin  
res:=0;
turns:= 0;
p:=c;
if (p_next=p)or(p_nextnext=p) then
  if an_angle (x_coord(p) - right_x(p),  y_coord(p) - right_y(p)) >= 0 then
     turn_cycles := unity
  else
     turn_cycles := -unity
else begin
  repeat
	xp := x_coord(p_next); yp := y_coord(p_next);
    ang  := bezier_slope(x_coord(p), y_coord(p), right_x(p), right_y(p),  
                        left_x(p_next), left_y(p_next), xp, yp);
    if ang>seven_twenty_deg then begin
	    print_err("Strange path");
        error;
	    turn_cycles := 0;
	    return;
      end;
    res  := res + ang;
	{ incoming angle at next point }
	x := left_x(p_next);  y := left_y(p_next);
	if (xp=x)and(yp=y) then begin x := right_x(p);  y := right_y(p);  end;
	if (xp=x)and(yp=y) then begin x := x_coord(p);  y := y_coord(p);  end;
    in_angle := an_angle(xp - x, yp - y);
	{ outgoing angle at next point }
	x := right_x(p_next);  y := right_y(p_next);
	if (xp=x)and(yp=y) then begin x := left_x(p_nextnext);  y := left_y(p_nextnext);  end;
	if (xp=x)and(yp=y) then begin x := x_coord(p_nextnext); y := y_coord(p_nextnext); end;
    out_angle := an_angle(x - xp, y- yp);
    ang  := (out_angle - in_angle);
    res  := res + ang;
    while res >= three_sixty_deg do begin
      res := res - three_sixty_deg;
      turns := turns + unity;
    end;
    while res <= -three_sixty_deg do begin
      res := res + three_sixty_deg;
      turns := turns - unity;
    end;
    p := link(p);
  until p=c;
  turn_cycles := turns;
end;
exit:
end;
@z
