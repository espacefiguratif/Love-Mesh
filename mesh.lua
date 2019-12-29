local mesh = {}
local colorLib = require(".color")

function mesh.newElement( typeOfElement , properties , childs )
  return {t= typeOfElement, p= properties , c= childs or {} }
end
function mesh.getMeasurementsWidth( element , parentWidth )
  local margin = element.p.margin or {0, "px"}
  local marginRight = element.p.marginRight or margin
  local marginLeft = element.p.marginLeft or margin
  local width = element.p.width or {1, "fr"}
  --
  if width[2] == "%" then width = {width[1]/100*parentWidth,"px"} end
  if marginLeft[2] == "%" then marginLeft = {marginLeft[1]/100*parentWidth,"px"} end
  if marginRight[2] == "%" then marginRight = {marginRight[1]/100*parentWidth,"px"} end
  --
  local res = { {0, "px"}, {0, "fr"} }
  if width[2] == "fr" then       res[2][1] = res[2][1] + width[1]       else res[1][1] = res[1][1] + width[1] end
  if marginRight[2] == "fr" then res[2][1] = res[2][1] + marginRight[1] else res[1][1] = res[1][1] + marginRight[1] end
  if marginLeft[2] == "fr" then  res[2][1] = res[2][1] + marginLeft[1]  else res[1][1] = res[1][1] + marginLeft[1] end
  
  return res[1],res[2]
end
function mesh.getMeasurementsHeight( element , parentHeight )
  local margin = element.p.margin or {0, "px"}
  local marginTop = element.p.marginTop or margin
  local marginBottom = element.p.marginBottom or margin
  local height = element.p.height or {1,"fr"}
  --
  if height[2] == "%" then height = {height[1]/100*parentHeight,"px"} end
  if marginTop[2] == "%" then marginTop = {marginTop[1]/100*parentHeight,"px"} end
  if marginBottom[2] == "%" then marginBottom = {marginBottom[1]/100*parentHeight,"px"} end
  --
  local res = { {0, "px"}, {0, "fr"} }
  if height[2] == "fr" then        res[2][1] = res[2][1] + height[1]       else res[1][1] = res[1][1] + height[1] end
  if marginTop[2] == "fr" then     res[2][1] = res[2][1] + marginTop[1]    else res[1][1] = res[1][1] + marginTop[1] end
  if marginBottom[2] == "fr" then  res[2][1] = res[2][1] + marginBottom[1] else res[1][1] = res[1][1] + marginBottom[1] end
  
  return res[1],res[2]
end
function mesh.renderElements( node , x , y , frameWidth , frameHeight , frRelative , frSizeX , frSizeY )
  local frRe = frRelative or false
  if node.t == "struct" then
    local backgroundColor = node.p.backgroundColor or {255,255,255,"rgb"}
    if backgroundColor[#backgroundColor]=="rgb" then
      love.graphics.setColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
    elseif backgroundColor[#backgroundColor]=="rgba" then
      love.graphics.setColor(backgroundColor[1], backgroundColor[2], backgroundColor[3], backgroundColor[4])
    elseif backgroundColor[#backgroundColor]=="#" then
      love.graphics.setColor(colorLib.get('#'..backgroundColor[1]))
    elseif backgroundColor[#backgroundColor]=="name" then
      love.graphics.setColor(colorLib.get(backgroundColor[1]))
    end
    love.graphics.push()
    love.graphics.translate(x, y)
    
    local marginLeft = node.p.marginLeft or {0, 'px'}
    local marginTop = node.p.marginTop or {0, 'px'}
    local width = node.p.width or {0, 'px'}
    local height = node.p.height or {0, 'px'}
    local borderRadius = node.p.borderRadius or {0, 0, 'px'}
    
    if height[2] == "%" then height = {height[1]/100*frameHeight,"px"} end
    if width[2] == "%" then width = {width[1]/100*frameWidth,"px"} end
    if marginLeft[2] == "%" then marginLeft = {marginLeft[1]/100*frameWidth,"px"} end
    if marginTop[2] == "%" then marginTop = {marginTop[1]/100*frameHeight,"px"} end
    if borderRadius[3] == "%" then borderRadius = {borderRadius[1]/100*frameWidth,borderRadius[2]/100*frameHeight,"px"} end
    
    local maxSizeWidth = { {0, "px"}, {0, "fr"} }
    local maxSizeHeight = { {0, "px"}, {0, "fr"} }
    
    for i,v in pairs(node.c) do
      local responce1, responce2 = mesh.getMeasurementsWidth(v, frameWidth)
      maxSizeWidth[1][1], maxSizeWidth[2][1] = maxSizeWidth[1][1] + responce1[1], maxSizeWidth[2][1] + responce2[1]
    end
    
    for i,v in pairs(node.c) do
      local responce1, responce2 = mesh.getMeasurementsHeight(v, frameHeight)
      maxSizeHeight[1][1], maxSizeHeight[2][1] = maxSizeHeight[1][1] + responce1[1], maxSizeHeight[2][1] + responce2[1]
    end
    
    local frSizeW = 0
    local frSizeH = 0
    
    if maxSizeWidth[2][1] ~= 0 then
      frSizeW = (frameWidth - maxSizeWidth[1][1]) / maxSizeWidth[2][1]
    end
    
    if maxSizeHeight[2][1] ~= 0 then
      frSizeH = (frameHeight - maxSizeHeight[1][1]) / maxSizeHeight[2][1]
    end
  
    if frRelative then
      if height[2] == "fr" then height = {height[1] * frSizeY,"px"} end
      if width[2] == "fr" then width = {width[1] * frSizeX,"px"} end
      if marginLeft[2] == "fr" then marginLeft = {marginLeft[1] * frSizeX,"px"} end
      if marginTop[2] == "fr" then marginTop = {marginTop[1] * frSizeY,"px"} end
    else
      if height[2] == "fr" then height = {frameHeight,"px"} end
      if width[2] == "fr" then width = {frameWidth,"px"} end
      if marginLeft[2] == "fr" then marginLeft = {frameWidth,"px"} end
      if marginTop[2] == "fr" then marginTop = {frameHeight,"px"} end
    end
    
    love.graphics.rectangle('fill', marginLeft[1], marginTop[1], width[1], height[1], borderRadius[1], borderRadius[2], 200)
    love.graphics.pop()
    
    local positionX = 0
    local positionY = 0
    
    for i,v in pairs(node.c) do
      mesh.renderElements( v , marginLeft[1] + positionX + x, marginTop[1] + positionY + y, width[1] , height[1] , true , frSizeW , frSizeH )
      local responce0W1, responce0W2 = mesh.getMeasurementsWidth( v , width[1] )
      local responce0H1, responce0H2 = mesh.getMeasurementsHeight( v , height[1] )
      positionX = positionX + responce0W1[1] + responce0W2[1] * frSizeW
      if positionX >= width[1] then
        positionX = 0
        positionY = positionY + responce0H1[1] + responce0H2[1] * frSizeH
      end
    end
  elseif node.t == "text" then
    local color = node.p.color or {255,255,255,"rgb"}
    if color[#color]=="rgb" then
      love.graphics.setColor(color[1], color[2], color[3])
    elseif color[#color]=="rgba" then
      love.graphics.setColor(color[1], color[2], color[3], color[4])
    elseif color[#color]=="#" then
      love.graphics.setColor(colorLib.get('#'..color[1]))
    elseif color[#color]=="name" then
      love.graphics.setColor(colorLib.get(color[1]))
    end
    love.graphics.push()
    love.graphics.translate(x, y)
    
    local marginLeft = node.p.marginLeft or {0, 'px'}
    local marginTop = node.p.marginTop or {0, 'px'}
    local width = node.p.width or {0, 'px'}
    local height = node.p.height or {0, 'px'}
    local fontSize = node.p.fontSize or {20, 'px'}
    local text = node.p.text or ""
    local fontAlignment = node.p.fontAlignment or "left"
    
    if height[2] == "%" then height = {height[1]/100*frameHeight,"px"} end
    if width[2] == "%" then width = {width[1]/100*frameWidth,"px"} end
    if marginLeft[2] == "%" then marginLeft = {marginLeft[1]/100*frameWidth,"px"} end
    if marginTop[2] == "%" then marginTop = {marginTop[1]/100*frameHeight,"px"} end
    if fontSize[2] == "%" then fontSize = {fontSize[1]/100*frameWidth,"px"} end
    
    if frRelative then
      if height[2] == "fr" then height = {height[1] * frSizeY,"px"} end
      if width[2] == "fr" then width = {width[1] * frSizeX,"px"} end
      if marginLeft[2] == "fr" then marginLeft = {marginLeft[1] * frSizeX,"px"} end
      if marginTop[2] == "fr" then marginTop = {marginTop[1] * frSizeY,"px"} end
      if fontSize[2] == "fr" then fontSize = {fontSize[1] * frSizeX,"px"} end
    else
      if height[2] == "fr" then height = {frameHeight,"px"} end
      if width[2] == "fr" then width = {frameWidth,"px"} end
      if marginLeft[2] == "fr" then marginLeft = {frameWidth,"px"} end
      if marginTop[2] == "fr" then marginTop = {frameHeight,"px"} end
      if fontSize[2] == "fr" then fontSize = {frameWidth,"px"} end
    end
    
    local actualFont = love.graphics.getFont()
    actualFont:setFilter('nearest', 'nearest')
    
    love.graphics.printf(text, marginLeft[1], marginTop[1], width[1]/(fontSize[1]/actualFont:getHeight(text)), fontAlignment, 0, fontSize[1]/actualFont:getHeight(text))
    love.graphics.pop()
  end
end

return mesh