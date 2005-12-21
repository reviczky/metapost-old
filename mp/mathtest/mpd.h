/* $Id: mpd.h,v 1.2 2004/09/19 21:27:32 karl Exp $
   mpd.h.  Public domain.  */

#undef	TRIP
#undef	TRAP
#define	STAT
#undef	DEBUG
#include "mp.h"
/* 1 9998 9999 */ 
typedef integer scaled  ; 
typedef integer fraction  ; 
typedef integer strnumber  ; 
EXTERN boolean aritherror  ; 

fraction zmakefraction();
integer ztakefraction();
integer ztakescaled();
scaled zmakescaled();
fraction qmakefraction();
integer qtakefraction();
integer qtakescaled();
scaled qmakescaled();
