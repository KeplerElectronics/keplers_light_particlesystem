pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--kepler's light particlesystem

particles = {} 
--generates empty container for
--all particles

function spawnparticle (x,y,vx,vy,c,l)
 particle = {}
 particle.x = x
 particle.y = y
 particle.velx = vx
 particle.vely = vy
 particle.clr = c
 particle.life = l
 add(particles,particle)
end
--creates smaller container for
--individual particles, adds
--to master container

function particlelogic ()
 for particle in all(particles) do
  particle.life -= 1
  particle.x += particle.velx
  particle.y += particle.vely
  if particle.life <= 0 then
   del (particles,particle)
  end
 end
end
--acts on every particle
--reducing life value and 
--deleting when 0
--changes x,y based on velocity

--77 tokens for just the 
--particle generation and logic


function stars ()
local sc = flr(rnd(2))
--star counter to thin out stars
 if sc == 1 then 
  spawnparticle(flr(rnd(126)),
  --andomizes x spawn
  0,
  --spawns at top of screen
  0,
  --spawns with 0 x momentum
  flr(rnd(4))+1,
  --randomizes y momentum to get
  --fake parallax effect
  flr(rnd(15)),
  --randomizes color
  128)
  --keeps particle alive until
  --it runs offscreen 

 end
end



function _update60()
 stars()
 particlelogic()
end

function _draw()
 cls()
 for particle in all(particles) do
  pset(particle.x,particle.y,particle.clr)
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
