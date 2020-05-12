BaseModel = {}
BaseModel.__index = BaseModel

local __storageName = 'basemodel.store';
BaseModel.__primaryKey = 'id';

function BaseModel.create()
   local bm = {}
   setmetatable(bm,BaseModel)
   return bm
end

function BaseModel:mysplit (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function BaseModel:find(id)

    local bm = BaseModel:create()
    local file = io.open("database\\"..__storageName,"r+")
    
    local count = 1;

    local line = false

    for _line in file:lines() do
        if count == id then
            line = _line
        end
        count = count + 1
    end

    local t = false

    if line ~= false then
        t = self:mysplit(line, ';')
        for i,__line in ipairs(t) do
            local _t = self:mysplit(__line,':')
            bm.map(bm,_t[1],_t[2])
        end
    end

    file:close()
    return bm
end

function BaseModel.save(bm)
    local charString = ""
    for key,value in pairs(bm) do
        charString = charString .. key .. ":" .. value .. ";"
    end
    local file = io.open("database\\"..__storageName,"a")
    io.output(file)
    io.write(charString .. "\r")
    io.close(file)
end


function BaseModel.map(bm,key,value)
    bm[key] = value
end

function BaseModel.getAll(bm)

    local file = io.open("database\\"..__storageName,"r+")
    
    local count = 1;

    local return_t = {}

    for _line in file:lines() do
        if _line ~= '-' and _line ~= nil then
            local temp_table = {}
            
            local tSplittedLines = bm:mysplit(_line, ';')
            for key,value in ipairs(tSplittedLines) do
                local tSplittedPairs = bm:mysplit(value,':')
                temp_table[tSplittedPairs[1]] = tSplittedPairs[2]
                temp_table[BaseModel.__primaryKey] = count
            end
            table.insert(return_t,temp_table)
        end
        count = count + 1
    end
    return return_t
end