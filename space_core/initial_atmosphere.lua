function initial_atmosphere()
    local players = core.get_connected_players()

    for _, player in ipairs(players) do
        local pos = player:get_pos()

        --atmospheric layers
            if pos.y < 1000 and space.atmosphere[player] ~= 0 then
                --Troposphere
                space.atmosphere[player] = 0
                
        
            elseif pos.y >= 1000 and pos.y < 5000 and space.atmosphere[player] ~= 1 then
                --stratosphere
                space.atmosphere[player] = 1
                
            elseif pos.y >= 5000 and pos.y < 10000 and space.atmosphere[player] ~= 2 then
                --thermosphere
                space.atmosphere[player] = 2
                
            elseif pos.y >= 10000 and pos.y < 20000 and space.atmosphere[player] ~= 3 then
                --exosphere
                space.atmosphere[player] = 3
                
            elseif pos.y >= 20000 and space.atmosphere[player] ~= 4 then
                --moon 
                space.atmosphere[player] = 4
                
            end

    end
end

