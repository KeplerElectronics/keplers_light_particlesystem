
--Variables
	allparticles = {}

function love.load()

end

function love.update(dt)
	particlelogic()
end

function love.draw()
	for i,particle in ipairs(allparticles) do
        love.graphics.draw(particle.img, particle.x, particle.y, math.rad(particle.rot), 0.25, 0.25, Bullet:getWidth()/2, Bullet:getHeight()/2)
    end
end



function spawnparticle(x,y,vx,vy,l,dmg,rot,img)
	particle = {
		x = x,
		y = y,
		vx = vx,
		vy = vy, 
		life = l,
		dmg = dmg,
		rot = rot,
		img = img
	}
	table.insert(allparticles, particle)
end

function particlelogic()
	for i,particle in ipairs(allparticles) do
        particle.x = particle.x + particle.vx
        particle.y = particle.y + particle.vy 
    end
end
