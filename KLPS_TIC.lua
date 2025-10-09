
--drop into draw function
if #allparticles~=0 then
	for i,particle in ipairs(allparticles) do
		if particle.rad ==0 then
    		pix(particle.x-cam.x,particle.y-cam.y,particle.clr)
   		else
    		circ(particle.x-cam.x,particle.y-cam.y,particle.rad,particle.clr)
   		end
	end
end

-- call this function to spawn a particle
function spawnparticle(x,y,vx,vy,ax,ay,l,typ,clr,wall,rad,layer)
	particle = {
		x = x,
		y = y,
		vx = vx,
		vy = vy, 
		ax = ax,
		ay = ay,
		life = l,
		typ = typ,
		clr = clr,
		wall=wall,
		rad=rad,
		layer=layer
	}
	table.insert(allparticles, particle)
end

--this won't be applicable to most projects but is a decent look at one of my particle effect functions
function splat(x,y,r,c)
 	if not r then r=0  end
	if not c then c=10 end
 	local ay= 0.2
 	if gamestate~= "play" then ay=0 end
	for i=1,6,1 do
 		spawnparticle(x,y,(math.random(60)-30)/10,(math.random(60)-60)/10,0,ay,300,0,c,false,r,8)
	end
end

--annotated particle function call
spawnparticle(	p.x,--x
           		p.y,--y
				cos(sang+pi/21*i+r)*3,--vx
				sin(sang+pi/21*i+r)*3,--vy
				0,--ax
				0,--ay
				1000,--life
				6,--typ
				5,--clr
				false,--wall
				0,--rad
				7--layer
				)

--bloated particle draw function from Thwimbly, you can def cut this down but it's here if you want it :)

function particlelogic()
 beginparticlelogic = time()
 
 local tstall = time()
 local floor = math.floor
 local sin = math.sin
	for i,particle in ipairs(allparticles) do
	  if particle.wall==false then
	   particle.vx = particle.vx + particle.ax
				particle.vy = particle.vy + particle.ay
    particle.x = particle.x + particle.vx
    particle.y = particle.y + particle.vy 
   else
    particle.x = floor(particle.x)
    particle.y = floor(particle.y)
   end



   --everything below this is specific logic for different particle types, such as clouds, which don't despawn and are instead teleported to the opposite side of the screen since we only spawn them upon level load
   

   --clouds
   if particle.typ ~= 1 then
    particle.life = particle.life-1
   end
   
   if particle.life <=0 
   or particle.y>300 then
			 table.remove(allparticles,i)
			end
   
			if particle.typ==0 then
			 if solid(particle.x,particle.y) and particle.y >10 then
     table.remove(allparticles,i)
     --particle.wall = true
     
	   end
			elseif particle.typ == 1 then
			 if particle.x-cam.x <-50 then
				 particle.x = particle.x+300
				elseif particle.x-cam.x>300 then
				 particle.x = particle.x-350
				end
			 
			else if particle.typ == 2 then
			 particle.ax = sin(tstall+math.random(50))/50
			 particle.ay = sin(tstall)/200
			
			 if particle.y < waterlevel then
				 table.remove(allparticles,i)
				end
			
			elseif particle.typ == 3 then
			 --bubbles
				
				--accelerate based on sin
			 particle.ax = sin(tstall+math.random(50))/50
			 particle.ay = -0.00005+sin(tstall)/200
				--change radius as life decreases
				if particle.rad < 3 then
				 particle.rad = particle.rad+2/particle.life
			 end
				
				if mget((particle.x)//8,(particle.y)//8+(level-1)*34) == 188 then
				 particle.vx = 0.5
				elseif mget((particle.x)//8,(particle.y)//8+(level-1)*34) == 189 then
				 particle.vx = -0.5
				elseif mget((particle.x)//8,(particle.y)//8+(level-1)*34) == 190 then
				 particle.vy = 0.5
				elseif mget((particle.x)//8,(particle.y)//8+(level-1)*34) == 191 then
				 particle.vy = -0.5
				elseif solid(particle.x,particle.y) 
				or particle.y< waterlevel then
				 table.remove(allparticles,i)
				end
				
				
				
				--rain
			elseif particle.typ==4 
			and particle.y > 0 then
			 if solid(particle.x,particle.y)
				or oneway(particle.x,particle.y) then
     --particle.life = 4
     --particle.vy = -particle.vy/2
     --particle.vx = math.random(8)-4
     table.remove(allparticles,i)
    elseif halfwater == true 
    and particle.y>waterlevel then
     table.remove(allparticles,i)
    
	   end
				
			--dust poofs
			elseif particle.typ == 5 then
			 	 particle.rad = particle.rad-20/(particle.life)
			
			elseif particle.typ == 6 then
			   if particle.life <= 90 then
						 particle.grav = true
						end
					
					
			--digirain	
			elseif particle.typ == 7 then	
					
					
			elseif particle.typ == 8 then
				particle.ax = sin(tstall/100)/80
			
			end
		end
	end
	endparticlelogic=time()
end