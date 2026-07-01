-- API
space = {}
space.atmosphere = {}

--get initial atmosphere
dofile(core.get_modpath("space_core") .. "/initial_atmosphere.lua")
initial_atmosphere()
--

function space.get_layer(player)
    return space.atmosphere[player] or 0
end

--blocks
core.register_node("space_core:launch_pad", {
    description = "Launch Pad",
    tiles = {"launch_pad.png"},
    groups = {cracky = 1}
})

core.register_node("space_core:asteroid_stone", {
    description = "Asteroid stone",
    tiles = {"asteroid_stone.png"},
    groups = {
        cracky = 2,
        stone = 1
    }
})

core.register_node("space_core:asteroid_sulfur_ore", {
    description = "Asteroid sulfur ore",
    tiles = {"asteroid_sulfur.png"},
    groups = {
        cracky = 2,
    }
})

core.register_node("space_core:asteroid_titanium_ore", {
    description = "Asteroid titanium ore",
    tiles = {"asteroid_titanium.png"},
    groups = {
        cracky = 2,
    }
})

core.register_node("space_core:regolith", {
    description = "Moon regolith",
    tiles = {"regolith.png"},
    groups = {crumbly = 1,
                falling_node = 1,
                oddly_breakable_by_hand	= 1
             }

})

core.register_node("space_core:lunar_gravel", {
    description = "Moon gravel",
    tiles = {"lunargravel.png"},
    groups = {
        crumbly = 1,
        falling_node = 1
    }

})

core.register_node("space_core:lunar_stone", {
    description = "Moon stone",
    tiles = {"lunarstone.png"},
    groups = {cracky = 1, stone = 1},
})

core.register_node("space_core:station_center", {
    description = "Station center",
    tiles = {"station_center.png"},
    groups = {cracky = 1}
})
--alias
core.register_alias("regolith", "space_core:regolith")
core.register_alias("station_center", "space_core:station_center")
core.register_alias("moon_gravel", "space_core:lunar_gravel")
core.register_alias("moon_stone", "space_core:lunar_stone")
core.register_alias("asteroid_stone", "space_core:asteroid_stone")
core.register_alias("asteroid_sulfur_ore", "space_core:asteroid_sulfur_ore")
core.register_alias("asteroid_titanium_ore", "space_core:asteroid_titanium_ore")
core.register_alias("titanium_ingot", "space_core:titanium_ingot")
core.register_alias("sulfur_ingot", "space_core:sulfur_ingot")
-- items



--for recipes items
core.register_craftitem("space_core:sulfur_ingot", {
    description = "Sulfur ingot",
    inventory_image = "the_space_mod_sulfur_ingot.png"
})

core.register_craftitem("space_core:titanium_ingot", {
    description = "Titanium ingot",
    inventory_image = "the_space_mod_titanium_ingot.png"
})



--recipes

core.register_craft({
    type = "cooking",
    output = "space_core:sulfur_ingot",
    recipe = "space_core:asteroid_sulfur_ore",
    cooktime = 10
})

core.register_craft({
    type = "cooking",
    output = "space_core:titanium_ingot",
    recipe = "space_core:asteroid_titanium_ore",
    cooktime = 10
})
-- atmosphere

timer = 0
--gravity
local function set_gravity(layer, player)
    if space.get_layer(player) == 1 then
        player:set_physics_override({
            gravity = 0.9
        })
    end

    if space.get_layer(player) == 2 then
        player:set_physics_override({
            gravity = 0.4
        })
    end

    if space.get_layer(player) == 3 then
        player:set_physics_override({
            gravity = 0.2
        })
    end

    if space.get_layer(player) == 4 then
        player:set_physics_override({
            gravity = 0.6
        })
    end
    
end

--atmosphere propieties
local function atmosphere_effects(layer, player)
    --troposphere
    if layer == 0 then
        --sky
        player:set_sky({
            type = "regular"
        })
        
    elseif layer == 1 then
    --stratosphere
        --sky
        player:set_sky({
            type = "plain",
            base_color = "#114C7D"
        })
       
    elseif layer == 2 then
    --thermosphere
    --sky
        player:set_sky({
            type = "plain",
            base_color = "#042247"
        })
    elseif layer == 3 then
    --exosphere
    --sky
        player:set_sky({
            type = "plain",
            base_color = "#010514"
        })
    elseif layer == 4 then
        --moon 
        --sky
        player:set_sky({
            type = "plain",
            base_color = "#000000",  
        })
    end
end
--memory cleaning
        core.register_on_leaveplayer(function(player, timed_out)
            space.atmosphere[player] = nil
        end)

--detect atmosphere layer
core.register_globalstep(function(dtime)
    timer = timer + dtime
    local players = core.get_connected_players()
    if timer >= 3 then
        timer = 0
        
        
        --detect atmosphere
        
        for _, player in ipairs(players) do
            
            
        

            local pos = player:get_pos()
            --atmospheric layers
            if pos.y < 1000 and space.atmosphere[player] ~= 0 then
                --Troposphere
                space.atmosphere[player] = 0
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,"entered lower earth atmosphere")
                set_gravity(space.atmosphere[player], player)
        
            elseif pos.y >= 1000 and pos.y < 5000 and space.atmosphere[player] ~= 1 then
                --stratosphere
                space.atmosphere[player] = 1
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,"entered stratosphere")
                set_gravity(space.atmosphere[player], player)
            elseif pos.y >= 5000 and pos.y < 10000 and space.atmosphere[player] ~= 2 then
                --thermosphere
                space.atmosphere[player] = 2
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,"entered thermosphere")
                set_gravity(space.atmosphere[player], player)
            elseif pos.y >= 10000 and pos.y < 20000 and space.atmosphere[player] ~= 3 then
                --exosphere
                space.atmosphere[player] = 3
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name(), "entered upper earth atmosphere")
                set_gravity(space.atmosphere[player], player)
            elseif pos.y >= 20000 and space.atmosphere[player] ~= 4 then
                --moon 
                space.atmosphere[player] = 4
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,space.atmosphere[player] .. " moon WIP")
                set_gravity(space.atmosphere[player], player)
            end
            
            if space.atmosphere[player] >= 1 then
                if not space.has_life_support(player) then
                player:set_hp(player:get_hp() - 1)
                end
            end

            if space.has_backpack(player) then
                space.backpack_visuals(player)
                
            end
        end
    end

end)