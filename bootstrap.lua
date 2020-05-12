require("controllers.BaseModelController")
require("controllers.CharacterController")



function dump(o)
    local s = ''
    if type(o) == 'table' then
       s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       s = tostring(o)
    end
    return s
 end