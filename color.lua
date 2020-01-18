local color = {}
color.palette = require('./palette')
color.hexTable = { ["0"] = 0, ["1"] = 1, ["2"] = 2, ["3"] = 3, ["4"] = 4, ["5"] = 5, ["6"] = 6, ["7"] = 7, ["8"] = 8, ["9"] = 9, ["A"] = 10, ["B"] = 11, ["C"] = 12, ["D"] = 13, ["E"] = 14, ["F"] = 15 }

function color.getColorByHex(hex)
  local hexadecimal = hex:gsub( "%X", "" ):upper()
  local buffer = {}
  for i = 1, #hexadecimal do
    table.insert( buffer, color.hexTable[ hexadecimal:sub( i, i ) ] )
  end
  if ( #hexadecimal == 3 or #hexadecimal == 4 ) then
    for i = 1, #hexadecimal do
      buffer[i] = buffer[i] * 17
    end
    return buffer
  elseif ( #hexadecimal == 6 or #hexadecimal == 8 ) then
    local responseColor = {}
    for i = 1, #hexadecimal / 2 do
      responseColor[i] = buffer[2*i] + buffer[2*i-1] * 16
    end
    return responseColor
  else
    return { 255, 255, 255, 0 }
  end
end

function color.getColorByRGBAstring(string)
  local colorRGBA = string:gsub( "%s", "" ):upper()
  if colorRGBA:sub(1, 4) == "RGB(" then
    colorRGBA = table.pack(colorRGBA:sub(5, -2):match("([^,]+),([^,]+),([^,]+)"))
    for k, v in ipairs(colorRGBA) do
        colorRGBA[k] = tonumber(v)
    end
    return colorRGBA
  elseif colorRGBA:sub(1, 5) == "RGBA(" then
    colorRGBA = table.pack(colorRGBA:sub(6, -2):match("([^,]+),([^,]+),([^,]+),([^,]+)"))
    for k, v in ipairs(colorRGBA) do
        colorRGBA[k] = tonumber(v)
    end
    return colorRGBA
  else
    return { 255, 255, 255, 0 }
  end
end

function color.getColorByName(name)
  if color.palette[name] then
    return color.palette[name]
  end
end

function color.getColorOverAll(info)
	if info:upper():sub(1, 3) == "RGB" then
		return color.getColorByRGBAstring(info)
	elseif info:sub(1, 1) == "#" then
		return color.getColorByHex(info)
	else
		return color.getColorByName(info)
	end
end

return color