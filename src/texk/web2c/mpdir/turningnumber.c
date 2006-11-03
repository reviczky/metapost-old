/* $Id$ */

#include "mplib.h"

/* return more than 360 signal an err */

#define bezier_error (720<<20)+1

#define sign(v) ((v)>0 ? 1 : ((v)<0 ? -1 : 0 ))

#define print_roots(a)  fprintf(stdout,"\n%s, angles = %d,%d",(a),(xi)>>20,(xo)>>20)

angle 
bezierslope(integer AX,integer AY,integer BX,integer BY,integer CX,integer CY,integer DX,integer DY) {
  long long a,b,c,diff;
  long long ax=AX,ay=AY,bx=BX,by=BY,cx=CX,cy=CY,dx=DX,dy=DY;
  angle xi = 0, xo = 0, res = 0;
  integer deltax,deltay;

  deltax = (BX-AX); deltay = (BY-AY);
  if (deltax==0 && deltay == 0) { deltax=(CX-AX); deltay=(CY-AY); }
  if (deltax==0 && deltay == 0) { deltax=(DX-AX); deltay=(DY-AY); }
  xi = anangle(deltax,deltay);

  deltax = (DX-CX); deltay = (DY-CY);
  if (deltax==0 && deltay == 0) { deltax=(DX-BX); deltay=(DY-BY); }
  if (deltax==0 && deltay == 0) { deltax=(DX-AX); deltay=(DY-AY); }
  xo = anangle(deltax,deltay);

  assert(sizeof(long long)>=8);

  fprintf(stdout,"\nargs: (%lld,%lld),(%lld,%lld),(%lld,%lld),(%lld,%lld)",ax,ay,bx,by,cx,cy,dx,dy);
  
  a = ((bx-ax)*(cy-by)) - ((cx-bx)*(by-ay)); /* a = (bp-ap)x(cp-bp); */
  c = ((cx-bx)*(dy-cy)) - ((dx-cx)*(cy-by)); /* c = (cp-bp)x(dp-cp);*/
  b = ((bx-ax)*(dy-cy)) - ((by-ay)*(dx-cx)); /* b = (bp-ap)x(dp-cp);*/
  
  fprintf(stdout,"\nprod: a,b,c: (%lld,%lld,%lld)",a,b,c);
  fprintf(stdout,"\nsign: (%i,%i,%i)", sign(a),sign(b),sign(c));

  res = (xo-xi); /* ? */
  if ((a==0)&&(c==0)) {
    print_roots("no roots (a)");
  } else if ((a==0)||(c==0)) {
    if ((sign(b) == sign(a)) || (sign(b) == sign(c))) {
      print_roots("no roots (b)");
    } else {
      print_roots("one root (a)");
    }
  } else if ((sign(a)*sign(c))<0) {
    print_roots("one root (b)");
  } else {
    if (sign(a) == sign(b)) {
      print_roots("no roots (d)");
    } else {
      if ((b*b) < (4*a*c)) {
	print_roots("no roots (e)");
      } else if (b*b == 4*a*c) {
	print_roots("double root");
      } else {
	print_roots("two roots");
      }
    }
  }
  return res;
}
