local color={}
--
function color.get(name,alpha)
  if (string.sub(name,1,1)=="#") then -- Return a color based on Hex values
      local buffer = {}
      local input = name:sub(2) -- Hex values without the hashtag -> input
      
      if (#input==6) then -- Return a color based on Hex values with a length of 6
        for i=1,6 do
          table.insert(buffer,color.hexTable[string.sub(input,i,i)])
        end
        for i=1,3 do
          buffer[(i-1)*2+1]=buffer[(i-1)*2+1]*16
        end
        return {buffer[1]+buffer[2],buffer[3]+buffer[4],buffer[5]+buffer[6],alpha}
      elseif (#input==8) then -- Return a color based on Hex values with a length of 8
        for i=1,8 do
          table.insert(buffer,color.hexTable[string.sub(input,i,i)])
        end
        for i=1,4 do
          buffer[(i-1)*2+1]=buffer[(i-1)*2+1]*16
        end
        return {buffer[1]+buffer[2],buffer[3]+buffer[4],buffer[5]+buffer[6],buffer[7]+buffer[8]}
      elseif (#input==3) then -- Return a color based on Hex values with a length of 3
        for i=1,3 do
          table.insert(buffer,color.hexTable[string.sub(input,i,i)]*17)
        end
        return {buffer[1],buffer[2],buffer[3],alpha}
      else
        return {255,255,255,alpha}
      end
  elseif (color.palette[name]) then -- Return a color based on names
    local color = color.palette[name]
    return {color[1],color[2],color[3],alpha}
  else -- Return white if the color doesn't exist
    return {255,255,255,alpha}
  end
end
--
color.palette={
  black={0,0,0},
  deep_grey={63,63,63},
  grey={127,127,127},
  light_grey={191,191,191},
  white={255,255,255},
  charcoal={21,20,20},
  light_red={255,0,0},
  red={191,0,0},
  deep_red={127,0,0},
  bordeaux={109,7,26},
  light_green={0,255,0},
  green={0,127,0},
  deep_green={0,63,0},
  light_blue={0,0,255},
  blue={0,0,127},
  deep_blue={0,0,63},
  cyan={0,128,128},
  yellow={255,255,0},
  deep_yellow={191,191,0},
  magenta={255,0,255},
  pink={255,127,255},
  purple={127,0,127},
  coral={255,127,80},
  orange={255,127,0},
  light_orange={255,191,0},
  deep_orange={191,63,0},
  web_1={17,17,17},
  web_2={34,34,34},
  web_3={51,51,51},
  web_4={68,68,68}
}
--
color.hexTable={
  ["0"]=0,
  ["1"]=1,
  ["2"]=2,
  ["3"]=3,
  ["4"]=4,
  ["5"]=5,
  ["6"]=6,
  ["7"]=7,
  ["8"]=8,
  ["9"]=9,
  
  ["a"]=10,
  ["b"]=11,
  ["c"]=12,
  ["d"]=13,
  ["e"]=14,
  ["f"]=15,
  
  ["A"]=10,
  ["B"]=11,
  ["C"]=12,
  ["D"]=13,
  ["E"]=14,
  ["F"]=15
}
--
return color