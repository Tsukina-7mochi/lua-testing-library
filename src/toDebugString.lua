local toDebugString = nil

---@param value table
---@return string
local function arrayPartToString(value)
    local result = ""
    local indices = {}

    for k, _ in pairs(value) do
        if type(k) == "number" then
            table.insert(indices, k)
        end
    end

    if #indices == 0 then
        return ""
    end

    table.sort(indices)

    if indices[1] ~= 1 then
        result = result .. indices[1] .. " = "
    end
    result = result .. toDebugString(value[indices[1]]) .. ", "

    for i = 2, #indices do
        local valueString = toDebugString(value[indices[i]])
        local diff = indices[i] - indices[i - 1]

        if diff == 1 then
            result = result .. valueString .. ", "
        elseif diff == math.floor(diff) and diff < 10 then
            result = result .. string.format("(empty x %d), %s, ", diff, valueString)
        else
            result = result .. string.format("%s = %s, ", tostring(indices[i]), valueString)
        end
    end

    return result:sub(1, -3)
end

---@param value table
---@return string
local function mapPartToString(value)
    local result = ""
    local keys = {}

    for k, _ in pairs(value) do
        if type(k) == "string" then
            table.insert(keys, k)
        end
    end

    table.sort(keys)

    for _, key in pairs(keys) do
        result = result .. string.format("%s = %s, ", key, toDebugString(value[key]))
    end

    return result:sub(1, -3)
end

toDebugString = function(value)
    if type(value) == "string" then
        return "\"" .. value .. "\""
    elseif type(value) == "table" then
        local arrayPart = arrayPartToString(value)
        local mapPart = mapPartToString(value)

        if #arrayPart == 0 and #mapPart == 0 then
            return "{}"
        elseif #arrayPart == 0 then
            return "{ " .. mapPart .. " }"
        elseif #mapPart == 0 then
            return "{ " .. arrayPart .. " }"
        else
            return "{ " .. arrayPart .. ", " .. mapPart .. " }"
        end
    end

    return tostring(value)
end

return toDebugString
