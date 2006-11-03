/* $Id$ */

#include "mplib.h"

/* return more than 360 signal an err */

#define bezier_error (720<<20)+1

#define sign(a) ((a)>0 ? 1 : ((a)<0 ? -1 : 0))

angle 
bezierslope(integer ax,integer ay,integer bx,integer by,integer cx,integer cy,integer dx,integer dy) {
  long long a,b,c;
  integer 
  angle x = 0;
  assert(sizeof(long long)>=8);
  /* a = (bp-ap)x(cp-bp);*/
                                            /* a = ((bx-ax),(by-ay)) x ((cx-bx),(cy-by));*/
  a = (bx-ax)*(cy-by) - (by-ay)*(cx-bx);
  /* c = (cp-bp)x(dp-cp);*/
  c = (cx-bx)*(dy-cy) - (cy-by)*(dx-cx);
  /* b = (bp-ap)x(dp-cp);*/
  b = (bx-ax)*(dy-cy) - (by-ay)*(dx-cx);
  if ((a==0)&&(c==0)) {
	/* no roots */
  } else if ((a==0)||(c==0)) {
	if ((sign(b) == sign(a)) || (sign(b) == sign(c))) {
	  /* no roots */
	} else {
	  /* one root */
	}
  } else if (sign(a)*sign(c)<0) {
	/* one root */
  } else {
	if (sign(a) == sign(b)) {
	  /* no roots */
	} else {
	  if (b**2 < 4*a*c) {
		/* no roots */
	  } else if (b**2 == 4*a*c) {
		/* a double root */
	  } else {
		/* two roots */
	  }
	}
  }
  return (90<<20); /* 90 degrees */
}
