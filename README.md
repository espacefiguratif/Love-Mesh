# Löve-Mesh
A simple lua UI library for Löve2D Framework

## Advancement.

<ins>Available types :</ins>
- [ ] Image
- [ ] Button
- [ ] Slider
- [x] Text
- [x] Struct


<ins>Available units :</ins>
- [x] fr ( fraction unit )
- [x] px
- [x] %

## How to use it.

<ins>To import this library :</ins>
  ```lua
    local mesh = require('.mesh')
  ```


<ins>To create an element :</ins>
  ```lua
    local element1 = mesh.newElement( type, properties, childs )
  ```
  
  | Variable      | Type          |
  | ------------- |:-------------:|
  | type          | String        |
  | properties    | Table         |
  | childs        | Table         |
  | element1      | Table         |
  
  
  
<ins>To render an element with his childs :</ins>
  ```lua
    function love.draw()
      mesh.renderElements( element1, x, y, width, height )
    end
  ```
  
  | Variable      | Type          | Comment                                |
  | ------------- |:-------------:|:--------------------------------------:|
  | element1      | Table         | A table containing my element          |
  | x             | Integer       | Where to draw on the x-axis            |
  | y             | Integer       | Where to draw on the y-axis            |
  | width         | Integer       | Length on the x-axis of the draw field |
  | height        | Integer       | Length on the y-axis of the draw field |
  
  
## License & copyright.

© Tom ROUET 

Licensed under the [GNU License](LICENSE).
