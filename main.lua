local isDown = love.keyboard.isDown
local bool = { [true] = 1, [false] = 0 }
local speed = 1
local ball = { x = 0, y = 0, vx = -speed, vy = speed, r = 5 }
local pad1_y = 0
local pad2_y = 0
local score1 = 0
local score2 = 0
local width, height = love.graphics.getDimensions()
local paddleWidth, paddleHeight = 10, 50

function love.update()
	pad1_y = pad1_y + (bool[isDown"down"] - bool[isDown"up"]) * 3
	pad2_y = pad2_y + (bool[isDown"j"] - bool[isDown"i"]) * 3
	if pad1_y < 0 then pad1_y = 0 end
	if pad1_y > height - paddleHeight then pad1_y = height - paddleHeight end
	if pad2_y < 0 then pad2_y = 0 end
	if pad2_y > height - paddleHeight then pad2_y = height - paddleHeight end
	ball.x = ball.x + ball.vx
	ball.y = ball.y + ball.vy
	if ball.y - ball.r < 0 then 
		ball.y = 0 + ball.r
		ball.vy = -ball.vy 
	elseif ball.y + ball.r > height then
		ball.y = height - ball.r
		ball.vy = -ball.vy
	end

	if ball.x < 10 + paddleWidth then
		speed = speed * 1.05
		ball.x = 10 + paddleWidth
		ball.vx = speed
		ball.vy = ball.vy
	end
	
	if ball.x < 0 then
		ball.x = width / 2
		ball.vx = -ball.vx
		score2 = score2 + 1
	end
	
	if ball.x > width - 10 - paddleWidth then
		speed = speed * 1.05
		ball.x = width - 10 - paddleWidth
		ball.vx = -speed
		ball.vy = ball.vy
	end
	
	if ball.x > 320 then
		ball.x = width / 2
		ball.vx = -ball.vx
		score1 = score1 + 1
	end
	if score1 > 6 or score2 > 6 then
		print("player " .. (score1 > score2 and 1 or 2) .. " wins.")
		love.event.quit()
	end
end

function love.draw()
	love.graphics.rectangle("fill", 10, pad1_y, paddleWidth, paddleHeight)
	love.graphics.rectangle("fill", width - 10 - paddleWidth, pad2_y, paddleWidth, paddleHeight)
	love.graphics.circle("fill", ball.x, ball.y, ball.r)
	love.graphics.print(score1, 10, 10)
	love.graphics.print(score2, width - 20, 10)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
