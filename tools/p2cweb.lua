

local file = io.open('mp.web')
local data = file:read('*a')
file:close()

webmodules = {}
function storemodule (a)
   webmodules[#webmodules+1] = a
end

modulestart = lpeg.P("@ ") + lpeg.P("@* ")
module = lpeg.C(modulestart * (1 - modulestart)^1) / storemodule
limbo = (1 - modulestart)^1
modules = limbo * module^1

lpeg.match(modules, data)

for a,_ in pairs(webmodules) do
   print(a, string.sub(_,1,50))
end




