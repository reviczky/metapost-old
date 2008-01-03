#!/usr/bin/env texlua



function parse_pascal (code) 
   local tree = code
   local P, R, S, C =  lpeg.P, lpeg.R, lpeg.S, lpeg.C
   local comments = {}
   local the_tokens = {}
   code = string.gsub (code,"@{","@B")
   code = string.gsub (code,"@}","@E")
   code = string.gsub (code,"\\\\","@S")
   code = string.gsub (code,"\\{","@b")
   code = string.gsub (code,"\\}","@e")
   code = string.gsub (code,"(@:.-@>)",function (body)
					comments[#comments+1] = body
                                        return "@D" .. #comments
                                  end)
   code = string.gsub(code,"(%b{})", function (body)
					body = string.gsub(body,"@S","\\\\")
					body = string.gsub(body,"@b","\\{")
					body = string.gsub(body,"@e","\\}")
					comments[#comments+1] = body
                                        return "@C" .. #comments
				     end)
   
   local function do_token (a) the_tokens[#the_tokens+1] = a end
   local function do_identifier (...) do_token(...) end
   local function do_space (...) do_token(...)  end
   local function do_whatever (...)  do_token(...)  end
   local function do_keyword (...) do_token(...)  end
   local function do_operator (...) do_token(...)  end
   local function do_literal (...) do_token(...)  end
   local function do_macro (...) do_token(...)  end
   local function do_webcommand (a,b) 
      if a == "@B" then 
	 do_token("@{") 
      elseif a == "@E" then
	 do_token("@}") 
      elseif a == "@D" then
	 do_token(comments[tonumber(b)]) 
      elseif a == "@C" then
	 do_token(comments[tonumber(b)]) 
      else
	 do_token(a)
      end
   end

   local whitespace = C(S' \t\v\n\f' ) / do_space
   local digit = R'09'
   local letter = R('az', 'AZ') + P'_'
   local letters = letter^1
   local alphanum = letter + digit
   local hex = R('af', 'AF', '09')
   local number = digit^1 +  digit^0 * P'.' * digit^1 +  digit^1 * P'.' * digit^0
   local charlit =  P"'" * (P'\\' * P(1) + (1 - S"\\'"))^1 * P"'"
   local stringlit = P'"' * (P'\\' * P(1) + (1 - S'\\"'))^0 * P'"'
   local literal = C(number + charlit + stringlit) / do_literal
   local keyword = C(
			P"and" +
			P"begin" +
			P"case" +
			P"const" +
			P"div" +
			P"do" +
			P"else" +
			P"end" +
			P"false" +
			P"function" +
			P"goto" +
			P"if" +
			P"mod" +
			P"or" +
			P"procedure" +
			P"label" +
			P"then" +
			P"true" +
			P"type" +
			P"var" +
			P"while"
		  ) / do_keyword
   local macro = C(P"\\" * (letters + 1)) / do_macro
   local identifier = (letter * alphanum^0 - keyword * (-alphanum)) / do_identifier
   local op = C(
		   P"==" +
		   P"<=" +
		   P">=" +
		   P":=" +
		   P"<>" +
		   P"!=" +
		   S";{},:=()[].-+*<>"
	     ) / do_operator
   local comment = C(P"@C") * C(number) / do_webcommand
   local webcommand = C(P"@" * 1) / do_webcommand
   local whatever = C(1) / do_whatever
   local tokens = (macro + identifier + keyword + comment + webcommand +
		   literal + op + whitespace + whatever)^0

   lpeg.match(tokens, code)
   return the_tokens
end


function read_modules (f) 
  local file = io.open(f)
  if not file then return nil  end
  local data = file:read('*a')
  file:close()
  if not data then return nil  end
  local webmodules = {}
  local function store_module (a) webmodules[#webmodules+1] = a  end
  local modulestart = lpeg.P("@ ") + lpeg.P("@\n") + lpeg.P("@*")
  local module = lpeg.C(modulestart * (1 - modulestart)^1) / store_module
  local limbo = lpeg.C((1 - modulestart)^1) / store_module
  local modules = limbo * module^1
  lpeg.match(modules, data)
  return webmodules  
end

function disect_module (m) 
   local a = { ["src"] = m }
   local function sdoc (v) a.doc  = v end
   local function sdef (v) a.adef  = v end
   local function scod (v) a.cod  = v end
   local non_doc = lpeg.P("@d") + lpeg.P("@f") + lpeg.P("@<") + lpeg.P("@p")
   local non_def = lpeg.P("@<") + lpeg.P("@p")
   local documentation = lpeg.C((1 - non_doc)^0) / sdoc
   local definitions = lpeg.C((1 - non_def)^0) / sdef
   local code = lpeg.C(lpeg.P(1)^0) / scod
   local parts = documentation * definitions * code
   lpeg.match(parts, m)
   if a.adef and #(a.adef)>0 then
      a.def = {}
      local function cdef (v) a.def[(#a.def)+1]  = v end
      local start_def = lpeg.P("@d")
      local start_fmt = lpeg.P("@f")
      local start = start_def + start_fmt
      local body_def = (1-start)^1
      local fmt = lpeg.C(start_fmt * body_def) / cdef
      local def = lpeg.C(start_def * body_def) / cdef
      local defs = (def + fmt)^1
      lpeg.match(defs, a.adef)
      a.adef = nil
   end
   return a
end

function disect_modules (webmodules) 
  local mods = {}
  for a,_ in pairs(webmodules) do
     mods[a] = disect_module(_)
     mods[a].nr = a-1 
  end
  return mods
end

function parse_module (module) 
  local space  = lpeg.S(" \t\n\r")^0
  local equal  = lpeg.P("=")
  local equals = lpeg.P("==")
  if module.def then
     for a,def in pairs(module.def) do
       local thedef = {}
       local function scode (v) thedef.code  = v end
       local function sname (v) thedef.name  = v end
       local function stype (v) thedef.type  = v end
       local param = lpeg.P("(#)") * space * equals
       local equaltype = lpeg.C((equals+equal+param)^1) / stype
       local definame = lpeg.C((1-equaltype)^1) / sname
       local body = lpeg.C(lpeg.P(1)^1) / scode
       local definition = (lpeg.P("@d")+lpeg.P("@f")) * space * definame * equaltype * space * body
       lpeg.match(definition,def)
       if thedef.code and #(thedef.code)>0 then
         thedef.code = parse_pascal (thedef.name .. thedef.type ..thedef.code)
       end
       module.def[a] = thedef
     end
  end
  if module.cod and #(module.cod)>0 then
      local function scode (v) module.code  = v end
      local function sname (v) module.name  = v end
      local name_end = lpeg.P("@>")
      local name_start = lpeg.P("@<")
      local name_body = lpeg.C((1-name_end)^1) / sname
      local name =  name_start * name_body * name_end
      local unnamed = lpeg.P("@p") 
      local body = lpeg.C(lpeg.P(1)^1) / scode
      local pascal = lpeg.P(lpeg.P(name * space * equal) + unnamed)^1 * space * body
      lpeg.match(pascal,module.cod)
      module.cod = nil
      if module.code and #(module.code)>0 then
         module.code = parse_pascal (module.code)
      end
  end
  return
end



function main () 
  local file = arg[1]
  if not file or not lfs.isfile(file) then
     print ("no pascal web file given")
    return 
  end
  local webmodules = read_modules (file) 
  if not webmodules then
     print ("file loading failed")
     return
  end
  webmodules = disect_modules (webmodules) 
  if not webmodules then
     print ("file disecting failed")
     return
  end
  for a,_ in pairs(webmodules) do
     parse_module(_)
  end

  for a,_ in pairs(webmodules) do
     print (_.nr,_.name, table.concat(_.code or {}))
  end
end


main()

