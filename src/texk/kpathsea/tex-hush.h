/* tex-hush.h: suppressing warnings?

   Copyright 1996 Karl Berry.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*/

#ifndef KPATHSEA_TEX_HUSH_H
#define KPATHSEA_TEX_HUSH_H

#include <kpathsea/c-proto.h>
#include <kpathsea/types.h>

/* Return true if WHAT is included in the TEX_HUSH environment
   variable/config value.  */
extern KPSEDLL boolean kpse_tex_hush P1H(const_string what);

#endif /* not KPATHSEA_TEX_HUSH_H */
