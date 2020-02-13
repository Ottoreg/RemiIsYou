-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

love.graphics.setDefaultFilter("nearest")


love.load = function()
  
  love.window.setMode(800,800)
  love.window.setTitle("Rémi is You by Ottoreg")
  
  boolGameMenu = true
  
  boolTouch = true
  
  boolRemiIsYou = false
  boolWallIsYou = false
  
  boolVictory = false
  
  offset = 75
  
  WIDTH = love.graphics.getWidth()
  HEIGHT = love.graphics.getHeight() - offset 
  
  sizeWidth = 10
  sizeHeight = 10
  sizeCellW = WIDTH / sizeWidth
  sizeCellH = HEIGHT / sizeHeight
  
  grid = {}
  
  for i = 1, WIDTH do
    grid[i] = {}
    for j = 1,HEIGHT do
      grid[i][j] = 0
    end
  end
    
  gridPlayer = {}
  
  for i = 1, sizeWidth do
    gridPlayer[i] = {}
    for j = 1,sizeHeight do
      gridPlayer[i][j] = 0
    end
  end 
  
  player = {}
  player.posX = sizeWidth/2
  player.posY = sizeHeight/2
  player.img = love.graphics.newImage("img/player01.png")
  
  player.UpdatePlayerPos = function()
  
    for i = 1, sizeWidth do
      for j = 1, sizeHeight do 
        gridPlayer[i][j] = 0
      end
    end
    
    gridPlayer[player.posX][player.posY] = 1
    
  end
  
  
  remi = {}
  remi.posX = 4
  remi.posY = 2
  remi.UpdateRemiPos = function()
    
    grid[remi.posX][remi.posY] = 1
    
  end
    
  is = {}
  is.posX = 4
  is.posY = 3
  is.UpdateIsPos = function()
    
    grid[is.posX][is.posY] = 2
    
  end
  
  
  you = {}
  you.posX = 4
  you.posY = 4
  you.UpdateYouPos = function()
    
    grid[you.posX][you.posY] = 3
    
  end 
  
  wall = {}
  wall.posX = 8
  wall.posY = 7
  wall.UpdateWallPos = function()
    
    grid[wall.posX][wall.posY] = 4
    
  end
  
  
  o_wall1 = {}
  o_wall1.posX = 9
  o_wall1.posY = 10
  o_wall1.UpdateObjWall1 = function()
    
    gridPlayer[o_wall1.posX][o_wall1.posY] = 2
    
  end
  
  o_wall2 = {}
  o_wall2.posX = 9
  o_wall2.posY = 9
  o_wall2.UpdateObjWall2 = function()
    
    gridPlayer[o_wall2.posX][o_wall2.posY] = 2
    
  end
  
  o_wall3 = {}
  o_wall3.posX = 10
  o_wall3.posY = 9
  o_wall3.UpdateObjWall3 = function()
    
    gridPlayer[o_wall3.posX][o_wall3.posY] = 2
    
  end
  
  
  o_flag = {}
  o_flag.posX = 10
  o_flag.posY = 10
  o_flag.UpdateObjFlag = function()
    gridPlayer[o_flag.posX][o_flag.posY] = 3
  end
  
  allObject = {}
  allObject[1] = remi
  allObject[2] = is
  allObject[3] = you
  allObject[4] = wall
  --[[allObject[5] = o_wall1
  allObject[6] = o_wall2
  allObject[7] = o_wall3
  allObject[8] = o_flag]]--
  
  remi.canBePush = false
  remi.checkPush = function(dir)
    
    local voisin = nil
    
    if dir == "up" then
      if remi.posY - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if remi.posY - 1 == v.posY and remi.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("up") == false then
            remi.canBePush = false
            return
          else
            remi.canBePush = true
            remi.posY = remi.posY - 1
            return
          end
        else
          remi.canBePush = true
          remi.posY = remi.posY - 1
          return true
        end
      end
    end
    
    if dir == "right" then
      if remi.posX + 1 > sizeWidth then
        return false
      else
        for i,v in ipairs(allObject) do
          if remi.posY == v.posY and remi.posX + 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("right") == false then
            remi.canBePush = false
            return
          else
            remi.canBePush = true
            remi.posX = remi.posX + 1
            return
          end
        else
          remi.canBePush = true
          remi.posX = remi.posX + 1
          return true
        end
      end
    end
    
    if dir == "down" then
      if remi.posY + 1 > sizeHeight then
        return false
      else
        for i,v in ipairs(allObject) do
          if remi.posY + 1 == v.posY and remi.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("down") == false then
            remi.canBePush = false
            return
          else
            remi.canBePush = true
            remi.posY = remi.posY + 1
            return
          end
        else
          remi.canBePush = true
          remi.posY = remi.posY + 1
          return true
        end
      end
    end
    
    if dir == "left" then
      if remi.posX - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if remi.posY == v.posY and remi.posX - 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then    
          if voisin.checkPush("left") == false then
            remi.canBePush = false
            return
          else
            remi.canBePush = true
            remi.posX = remi.posX - 1
            return
          end
        else
          remi.canBePush = true
          remi.posX = remi.posX - 1
          return true
        end
      end
    end
    
  end
  
  is.canBePush = false
  is.checkPush = function(dir)
     
    local voisin = nil
    
    if dir == "up" then
      if is.posY - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if is.posY - 1 == v.posY and is.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("up") == false then
            is.canBePush = false
            return
          else
            is.canBePush = true
            is.posY = is.posY - 1
            return
          end
        else
          is.canBePush = true
          is.posY = is.posY - 1
          return true
        end
      end
    end
    
    if dir == "right" then
      if is.posX + 1 > sizeWidth then
        return false
      else
        for i,v in ipairs(allObject) do
          if is.posY == v.posY and is.posX + 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("right") == false then
            is.canBePush = false
            return
          else
            is.canBePush = true
            is.posX = is.posX + 1
            return
          end
        else
          is.canBePush = true
          is.posX = is.posX + 1
          return true
        end
      end
    end
    
    if dir == "down" then
      if is.posY + 1 > sizeHeight then
        return false
      else
        for i,v in ipairs(allObject) do
          if is.posY + 1 == v.posY and is.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("down") == false then
            is.canBePush = false
            return
          else
            is.canBePush = true
            is.posY = is.posY + 1
            return
          end
        else
          is.canBePush = true
          is.posY = is.posY + 1
          return true
        end
      end
    end
    
    if dir == "left" then
      if is.posX - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if is.posY == v.posY and is.posX - 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("left") == false then
            is.canBePush = false
            return
          else
            is.canBePush = true
            is.posX = is.posX - 1
            return
          end
        else
          is.canBePush = true
          is.posX = is.posX - 1
          return true
        end
      end
    end
    
    
  end
  
  you.canBePush = false
  you.checkPush = function(dir)
    
    local voisin = nil
    
    if dir == "up" then
      if you.posY - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if you.posY - 1 == v.posY and you.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("up") == false then
            you.canBePush = false
            return
          else
            you.canBePush = true
            you.posY = you.posY - 1
            return
          end
        else
          you.canBePush = true
          you.posY = you.posY - 1
          return true
        end
      end
    end
    
    if dir == "right" then
      if you.posX + 1 > sizeWidth then
        return false
      else
        for i,v in ipairs(allObject) do
          if you.posY == v.posY and you.posX + 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("right") == false then
            you.canBePush = false
            return
          else
            you.canBePush = true
            you.posX = you.posX + 1
            return
          end
        else
          you.canBePush = true
          you.posX = you.posX + 1
          return true
        end
      end
    end
    
    if dir == "down" then
      if you.posY + 1 > sizeHeight then
        return false
      else
        for i,v in ipairs(allObject) do
          if you.posY + 1 == v.posY and you.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("down") == false then
            you.canBePush = false
            return
          else
            you.canBePush = true
            you.posY = you.posY + 1
            return
          end
        else
          you.canBePush = true
          you.posY = you.posY + 1
          return true
        end
      end
    end
    
    if dir == "left" then
      if you.posX - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if you.posY == v.posY and you.posX - 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("left") == false then
            you.canBePush = false
            return
          else
            you.canBePush = true
            you.posX = you.posX - 1
            return
          end
        else
          you.canBePush = true
          you.posX = you.posX - 1
          return true
        end
      end
    end
    
  end
  
  wall.canBePush = false
  wall.checkPush = function(dir)
    
    local voisin = nil
    
    if dir == "up" then
      if wall.posY - 1 < 1 then
        print("can push map top reached")
        return false
      else
        for i,v in ipairs(allObject) do
          if wall.posY - 1 == v.posY and wall.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          print("voisin != nil ")
          if voisin.checkPush("up") == false then
            wall.canBePush = false
            return
          else
            print("checkvoisin == true")
            wall.canBePush = true
            wall.posY = wall.posY - 1
            return
          end
        else
          wall.canBePush = true
          wall.posY = wall.posY - 1
          return true
        end
      end
    end
    
    if dir == "right" then
      if wall.posX + 1 > sizeWidth then
        return false
      else
        for i,v in ipairs(allObject) do
          if wall.posY == v.posY and wall.posX + 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("right") == false then
            wall.canBePush = false
            return
          else
            wall.canBePush = true
            wall.posX = wall.posX + 1
            return
          end
        else
          wall.canBePush = true
          wall.posX = wall.posX + 1
          return true
        end
      end
    end
    
    if dir == "down" then
      if wall.posY + 1 > sizeHeight then
        return false
      else
        for i,v in ipairs(allObject) do
          if wall.posY + 1 == v.posY and wall.posX == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("down") == false then
            wall.canBePush = false
            return
          else
            wall.canBePush = true
            wall.posY = wall.posY + 1
            return
          end
        else
          wall.canBePush = true
          wall.posY = wall.posY + 1
          return true
        end
      end
    end
    
    if dir == "left" then
      if wall.posX - 1 < 1 then
        return false
      else
        for i,v in ipairs(allObject) do
          if wall.posY == v.posY and wall.posX - 1  == v.posX then
            voisin = v
          end
        end
        if voisin ~= nil then
          if voisin.checkPush("left") == false then
            wall.canBePush = false
            return
          else
            wall.canBePush = true
            wall.posX = wall.posX - 1
            return
          end
        else
          wall.canBePush = true
          wall.posX = wall.posX - 1
          return true
        end
      end
    end
  end


  flag = {}
  flag.posX = 1
  flag.posY = 8
  flag.UpdateFlagPos = function()
    grid[flag.posX][flag.posY] = 5
  end
  
  is2 = {}
  is2.posX = 1
  is2.posY = 9
  is2.UpdateIs2Pos = function()
    grid[is2.posX][is2.posY] = 2
  end
  
  win = {}
  win.posX = 1
  win.posY = 10
  win.UpdateWinPos = function()
    grid[win.posX][win.posY] = 6
  end

end




love.update = function (dt)
  
  player.UpdatePlayerPos()
  remi.UpdateRemiPos()
  is.UpdateIsPos()
  you.UpdateYouPos()
  wall.UpdateWallPos()
  o_wall1.UpdateObjWall1()
  o_wall2.UpdateObjWall2()
  o_wall3.UpdateObjWall3()
  o_flag.UpdateObjFlag()
  flag.UpdateFlagPos()
  is2.UpdateIs2Pos()
  win.UpdateWinPos()
  CheckVictory()
  
end

love.draw = function()
  
  if boolGameMenu then
    love.graphics.setColor(255,20,147)
    love.graphics.print("Rémi",WIDTH/5,HEIGHT/4,0,5,5)
    love.graphics.setColor(255,255,255)
    love.graphics.print("Is",WIDTH/2.35,HEIGHT/4,0,5,5)
    love.graphics.setColor(255,0,0)
    love.graphics.print("You",WIDTH/2,HEIGHT/4,0,5,5)
    love.graphics.setColor(255,255,255)
    love.graphics.print("Press Space to Start",WIDTH/5,HEIGHT/2,0,3,3)
    love.graphics.print("Press R any time to reset the level",WIDTH/3,HEIGHT/1.75,0,1,1)

  else
    if boolVictory then
      love.graphics.print("Victory",WIDTH/2,HEIGHT/2,0,5,5)
    else
      love.graphics.print("Rémi is You", 25, 25, 0, 2, 2)
      DrawPlayer()
      DrawGrid()
    end
  end
  
  
end

love.keypressed = function(key)
  
  if boolGameMenu == true then
    if key == "space" then
      boolGameMenu = false
    end
  else
    if  boolTouch == true then
      
      if key == "r" then
        love.load()
        -- rajouter confirmation
      end
      
      -- deplacement player (rémi le dino)
      
      CheckPhrases()
      
      if boolRemiIsYou == true or boolWallIsYou == true then
        if  key == "up" then
          if boolRemiIsYou == true then
            if  player.posY > 1 then
              CheckGridWords("up", player.posX, player.posY)
              player.posY = player.posY - 1
            end
            boolTouch = false
          end
          if boolWallIsYou == true then
            if o_wall1.posY > 1 and o_wall2.posY > 1 and o_wall3.posY > 1 then
              -- a remplacer par un for each o_wall
              CheckGridWords("up", o_wall1.posX, o_wall1.posY)
              o_wall1.posY = o_wall1.posY - 1
              CheckGridWords("up", o_wall2.posX, o_wall2.posY)
              o_wall2.posY = o_wall2.posY - 1
              CheckGridWords("up", o_wall3.posX, o_wall3.posY)
              o_wall3.posY = o_wall3.posY - 1
            end
            boolTouch = false
          end
        end
        if  key == "right" then
          if boolRemiIsYou == true then
            if  player.posX < sizeWidth then
              CheckGridWords("right", player.posX, player.posY)
              player.posX = player.posX + 1
            end
            boolTouch = false
          end
          
          if boolWallIsYou == true then
            if o_wall1.posX < sizeWidth and o_wall2.posX < sizeWidth and o_wall3.posX < sizeWidth then
              -- a remplacer par un for each o_wall
              CheckGridWords("right", o_wall1.posX, o_wall1.posY)
              o_wall1.posX = o_wall1.posX + 1
              CheckGridWords("right", o_wall2.posX, o_wall2.posY)
              o_wall2.posX = o_wall2.posX + 1
              CheckGridWords("right", o_wall3.posX, o_wall3.posY)
              o_wall3.posX = o_wall3.posX + 1
            end
            boolTouch = false
          end
          
            
        end
        if  key == "down" then
          
          if boolRemiIsYou == true then
            if player.posY < sizeHeight then
              CheckGridWords("down", player.posX, player.posY)
              player.posY = player.posY + 1
            end
            boolTouch = false
          end
        
          if boolWallIsYou == true then
            if o_wall1.posY < sizeHeight and o_wall2.posY < sizeHeight and o_wall3.posY < sizeHeight then
              -- a remplacer par un for each o_wall
              CheckGridWords("down", o_wall1.posX, o_wall1.posY)
              o_wall1.posY = o_wall1.posY + 1
              CheckGridWords("down", o_wall2.posX, o_wall2.posY)
              o_wall2.posY = o_wall2.posY + 1
              CheckGridWords("down", o_wall3.posX, o_wall3.posY)
              o_wall3.posY = o_wall3.posY + 1
            end
            boolTouch = false
          end
        end
        if  key == "left" then          
          if boolRemiIsYou == true then
            if player.posX > 1 then
              CheckGridWords("left", player.posX, player.posY)
              player.posX = player.posX - 1
            end
            boolTouch = false
          end
          if boolWallIsYou == true then
            if o_wall1.posX > 1 and o_wall2.posX > 1 and o_wall3.posX > 1 then
              -- a remplacer par un for each o_wall
              CheckGridWords("left", o_wall1.posX, o_wall1.posY)
              o_wall1.posX = o_wall1.posX - 1
              CheckGridWords("left", o_wall2.posX, o_wall2.posY)
              o_wall2.posX = o_wall2.posX - 1
              CheckGridWords("left", o_wall3.posX, o_wall3.posY)
              o_wall3.posX = o_wall3.posX - 1
            end
            boolTouch = false
          end
        end
      end
    end
  end
end

love.keyreleased = function()
  boolTouch = true
end

DrawGrid = function()  
  
  --love.graphics.setColor(0.1,0.1,0.1)
  love.graphics.setColor(20,20,20)
  
  for i = 1, sizeWidth do
    for j = 1, sizeHeight do
      love.graphics.rectangle("line", (i-1)*sizeCellW,(j-1)*sizeCellH + offset  ,sizeCellW , sizeCellH)
      
      if  grid[i][j] == 1 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(255,20,147)       
        love.graphics.print("Rémi",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
      if  grid[i][j] == 2 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(255,255,255)        
        love.graphics.print("is",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
      if  grid[i][j] == 3 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(255,0,0)
        love.graphics.print("You",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
      if  grid[i][j] == 4 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(0,255,0,255)
        love.graphics.print("Wall",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
      if  grid[i][j] == 5 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(255,255,0,255)
        love.graphics.print("Flag",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
      if  grid[i][j] == 6 then
        --love.graphics.setColor(1,1,1)
        love.graphics.setColor(0,255,255,255)
        love.graphics.print("Win",((i-1)*sizeCellW) + sizeCellW/2 , ((j-1)*sizeCellH) + sizeCellH/2 + offset,0,1,1)
        --love.graphics.setColor(0.1,0.1,0.1)
        love.graphics.setColor(20,20,20)
      end
      
    end
  end
  
  --love.graphics.setColor(1,1,1)
  love.graphics.setColor(255,255,255)
  
end

DrawPlayer = function()
  
  for i = 1, sizeWidth do
    for j = 1, sizeHeight do
      if gridPlayer[i][j] == 1 then 
        love.graphics.draw(player.img,(i-1)*sizeCellW,(j-1)*sizeCellH + offset  ,0 , 0.15, 0.15)
      end
      if gridPlayer[i][j] == 2 then
        love.graphics.setColor(0,255,0,255)
        love.graphics.rectangle("fill",(i-1)*sizeCellW,(j-1)*sizeCellH + offset  ,sizeCellW , sizeCellH)
        love.graphics.setColor(255,255,255)
      end
      if gridPlayer[i][j] == 3 then
        love.graphics.setColor(255,255,0,255)
        love.graphics.rectangle("fill",(i-1)*sizeCellW,(j-1)*sizeCellH + offset  ,sizeCellW , sizeCellH)
        love.graphics.setColor(255,255,255)
      end

    end
  end
  
end



CheckGridWords = function(dir, i, j)
  
  if  dir == "up" then
    if grid[i][j - 1] == 1 then -- grid == remi
      grid[i][j - 1] = 0
      remi.checkPush("up")
      if  remi.canBePush == true then
        remi.canBePush = false
      end
    end
    if grid[i][j - 1] == 2 then -- grid == is
      grid[i][j - 1] = 0
      is.checkPush("up")
      if  is.canBePush == true then
        is.canBePush = false
      end
    end 
    if grid[i][j - 1] == 3 then -- grid == you
      grid[i][j - 1] = 0
      you.checkPush("up")
      if  you.canBePush == true then
        you.canBePush = false
      end
    end
    
    if grid[i][j - 1] == 4 then -- grid == wall
      grid[i][j - 1] = 0
      wall.checkPush("up")
      if  wall.canBePush == true then
        wall.canBePush = false
      end
    end
  
  end

  if dir == "right" then 
    if grid[i + 1][j] == 1 then -- grid == remi
      grid[i + 1][j] = 0
      remi.checkPush("right")
      if  remi.canBePush == true then
        remi.canBePush = false
      end
    end
    if grid[i + 1][j] == 2 then -- grid == is
      grid[i + 1][j] = 0
      is.checkPush("right")
      if  is.canBePush == true then
        is.canBePush = false
      end
    end 
    if grid[i + 1][j] == 3 then -- grid == you
      grid[i + 1][j] = 0
      you.checkPush("right")
      if  you.canBePush == true then
        you.canBePush = false
      end
    end
    if grid[i + 1][j] == 4 then -- grid == wall
      grid[i + 1][j] = 0
      wall.checkPush("right")
      if  wall.canBePush == true then
        wall.canBePush = false
      end
    end
  end
  
  if dir == "down" then
    if grid[i][j + 1] == 1 then -- grid == remi
      grid[i][j + 1] = 0
      remi.checkPush("down")
      if  remi.canBePush == true then
        remi.canBePush = false
      end
    end
    if grid[i][j + 1] == 2 then -- grid == is
      grid[i][j + 1] = 0
      is.checkPush("down")
      if  is.canBePush == true then
        is.canBePush = false
      end
    end 
    if grid[i][j + 1] == 3 then -- grid == you
      grid[i][j + 1] = 0
      you.checkPush("down")
      if  you.canBePush == true then
        you.canBePush = false
      end
    end
    if grid[i][j + 1] == 4 then -- grid == wall
      grid[i][j + 1] = 0
      wall.checkPush("down")
      if  wall.canBePush == true then
        wall.canBePush = false
      end
    end
  end
  
  if dir == "left" then
    if grid[i - 1][j] == 1 then -- grid == remi
      grid[i - 1][j] = 0
      remi.checkPush("left")
      if  remi.canBePush == true then
        remi.canBePush = false
      end
    end
    if grid[i - 1][j] == 2 then -- grid == is
      grid[i - 1][j] = 0
      is.checkPush("left")
      if  is.canBePush == true then
        is.canBePush = false
      end
    end 
    if grid[i - 1][j] == 3 then -- grid == you
      grid[i - 1][j] = 0
      you.checkPush("left")
      if  you.canBePush == true then
        you.canBePush = false
      end
    end
    if grid[i - 1][j] == 4 then -- grid == wall
      grid[i - 1][j] = 0
      wall.checkPush("left")
      if  wall.canBePush == true then
        wall.canBePush = false
      end
    end
  end
  
end


CheckPhrases = function()
  for i = 1, sizeWidth do
    for j = 1, sizeHeight do
      if grid[i][j] == 1 then -- case remi
        
        if grid[i + 1][j] == 2 and grid[i + 2][j] == 3 then -- case is and you en ligne
            boolRemiIsYou = true
        elseif grid[i][j + 1] == 2 and grid[i][j + 2] == 3 then -- case is and you en colonne
            boolRemiIsYou = true
        else
          boolRemiIsYou = false
        end
      end
      
      if grid[i][j] == 4 then -- case wall
        -- condition a mettre en place
        if grid[i + 1][j] == 2 and grid[i + 2][j] == 3 then -- case is and you en ligne
            boolWallIsYou = true
        elseif grid[i][j + 1] == 2 and grid[i][j + 2] == 3 then -- case is and you en colonne
            boolWallIsYou = true
        else
          boolWallIsYou = false
        end
      end
    end
  end  
end

CheckVictory = function()
  
  if  boolRemiIsYou == true and player.posX == o_flag.posX and player.posY == o_flag.posY then
    
    boolVictory = true
    
  end
  
  if  boolWallIsYou == true and ((o_wall1.posX == o_flag.posX and o_wall1.posY == o_flag.posY) or (o_wall2.posX == o_flag.posX and o_wall2.posY == o_flag.posY) or (o_wall3.posX == o_flag.posX and o_wall3.posY == o_flag.posY)) then
    
    boolVictory = true
    
  end  
  
end


-- correction a faire

-- o_wall peuvent etre traversé a corriger
-- flag is win phrase pas vérifié pour condition de victoire
-- les mots se supperposent quand push les uns sur les autres contre un mur