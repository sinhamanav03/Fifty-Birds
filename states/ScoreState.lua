--[[
    ScoreState Class
    Author: Manav Sinha
    manavsinha111@gmail.com

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

local medals={
    ['gold'] = love.graphics.newImage('gold.png'),
    ['silver'] = love.graphics.newImage('silver.png'),
    ['bronze'] = love.graphics.newImage('bronze.png')
}

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function checkRank(score)
    if score > 5 then
        return 'gold'
    elseif score > 3 then
        return 'silver'
    else
        return 'bronze'
    end
end


function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.draw(medals[checkRank(self.score)],VIRTUAL_WIDTH/2-medals[checkRank(self.score)]:getWidth()-30,VIRTUAL_HEIGHT/2-medals[checkRank(self.score)]:getHeight())
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end