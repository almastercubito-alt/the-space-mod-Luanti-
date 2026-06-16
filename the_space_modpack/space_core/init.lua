-- API
space = {}
space.atmosphere = {}
function space.get_layer(player)
    return space.atmosphere[player] or 0
end

--blocks
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
                falling_node = 1
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
core.register_alias("gas_tank", "space_core:gas_tank")
core.register_alias("electric_crafter", "space_core:electric_crafter")
core.register_alias("asteroid_stone", "space_core:asteroid_stone")
core.register_alias("asteroid_sulfur_ore", "space_core:asteroid_sulfur_ore")
core.register_alias("asteroid_titanium_ore", "space_core:asteroid_titanium_ore")
core.register_alias("titanium_ingot", "space_core:titanium_ingot")
core.register_alias("sulfur_ingot", "space_core:sulfur_ingot")
-- items
core.register_craftitem("space_core:gas_tank", {
    description = "Gas tank",
    inventory_image = "the_space_mod_gas_tank.png",
    stack_max = 1
})

--suit
armor:register_armor("space_core:presurized_helmet", {
    description = "Presurized helmet",
    inventory_image = "the_space_mod_presurized_helmet_icon.png",
    texture = "presurized_helmet.png",
    preview = "the_space_mod_presurized_helmet_priview.png",
    groups = {
        armor_head = 1,
        armor_heal = 2,
        armor_use = 200,
        life_support = 1
    }
})

armor:register_armor("space_core:oxigen_backpack", {
    description = "Oxigen backpack",
    inventory_image = "the_space_mod_oxigen_backpack_icon.png",
    texture = "the_space_mod_oxigen_backpack.png",
    preview = "",
    groups = {
        armor_torso = 1,
        armor_heal = 2,
        life_support= 1
    }
})
--for recipes items
core.register_craftitem("space_core:sulfur_ingot", {
    description = "Sulfur ingot",
    inventory_image = "the_space_mod_sulfur_ingot.png"
})

core.register_craftitem("space_core:titanium_ingot", {
    description = "Titanium ingot",
    inventory_image = "the_space_mod_titanium_ingot.png"
})
--machines
core.register_node("space_core:electric_crafter", {
    description = "Electric crafter",
    tiles = {"electric_crafter_up.png", -- y+
    "electric_crafter_sides.png", -- y-
    "electric_crafter_sides.png", -- x+
    "electric_crafter_sides.png", -- x-
    "electric_crafter_sides.png", -- z+
    "electric_crafter_front.png"},-- z-
    groups = {cracky = 2},

    paramtype2 = "4dir",
    on_place = core.rotate_node
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
-- life support
local function has_life_support(player)
    local name = player:get_player_name()

    if not armor.textures[name] then
        return false
    end

    local texture = armor.textures[name].armor or ""

    local helmet = string.find(texture, "presurized_helmet")
    local backpack = string.find(texture, "oxigen_backpack")

    return helmet and backpack
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
        
            elseif pos.y >= 1000 and pos.y < 5000 and space.atmosphere[player] ~= 1 then
                --stratosphere
                space.atmosphere[player] = 1
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,"entered stratosphere")
            elseif pos.y >= 5000 and pos.y < 10000 and space.atmosphere[player] ~= 2 then
                --thermosphere
                space.atmosphere[player] = 2
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,"entered thermosphere")
            elseif pos.y >= 10000 and pos.y < 20000 and space.atmosphere[player] ~= 3 then
                --exosphere
                space.atmosphere[player] = 3
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name(), "entered upper earth atmosphere")
            elseif pos.y >= 20000 and space.atmosphere[player] ~= 4 then
                --moon 
                space.atmosphere[player] = 4
                atmosphere_effects(space.atmosphere[player], player)
                core.chat_send_player(player:get_player_name() ,space.atmosphere[player] .. " moon WIP")
            end
            
            if space.atmosphere[player] >= 1 then
                if not has_life_support(player) then
                player:set_hp(player:get_hp() - 1)
                end
            end
        end
    end

end)