--blocks
core.register_node("the_space_mod:asteroid_stone", {
    description = "Asteroid stone",
    tiles = {"asteroid_stone.png"},
    groups = {
        cracky = 2,
        stone = 1
    }
})

core.register_node("the_space_mod:asteroid_sulfur_ore", {
    description = "Asteroid sulfur ore",
    tiles = {"asteroid_sulfur.png"},
    groups = {
        cracky = 2,
    }
})

core.register_node("the_space_mod:asteroid_titanium_ore", {
    description = "Asteroid titanium ore",
    tiles = {"asteroid_titanium.png"},
    groups = {
        cracky = 2,
    }
})

core.register_node("the_space_mod:regolith", {
    description = "Moon regolith",
    tiles = {"regolith.png"},
    groups = {crumbly = 1,
                falling_node = 1
             }

})

core.register_node("the_space_mod:lunar_gravel", {
    description = "Moon gravel",
    tiles = {"lunargravel.png"},
    groups = {
        crumbly = 1,
        falling_node = 1
    }

})

core.register_node("the_space_mod:lunar_stone", {
    description = "Moon stone",
    tiles = {"lunarstone.png"},
    groups = {cracky = 1, stone = 1},
})

core.register_node("the_space_mod:station_center", {
    description = "Station center",
    tiles = {"station_center.png"},
    groups = {cracky = 1}
})
--alias
core.register_alias("regolith", "the_space_mod:regolith")
core.register_alias("station_center", "the_space_mod:station_center")
core.register_alias("moon_gravel", "the_space_mod:lunar_gravel")
core.register_alias("moon_stone", "the_space_mod:lunar_stone")
core.register_alias("gas_tank", "the_space_mod:gas_tank")
core.register_alias("electric_crafter", "the_space_mod:electric_crafter")
core.register_alias("asteroid_stone", "the_space_mod:asteroid_stone")
core.register_alias("asteroid_sulfur_ore", "the_space_mod:asteroid_sulfur_ore")
core.register_alias("asteroid_titanium_ore", "the_space_mod:asteroid_titanium_ore")
core.register_alias("titanium_ingot", "the_space_mod:titanium_ingot")
core.register_alias("sulfur_ingot", "the_space_mod:sulfur_ingot")
-- items
core.register_craftitem("the_space_mod:gas_tank", {
    description = "Gas tank",
    inventory_image = "the_space_mod_gas_tank.png"
})
--for recipes items
core.register_craftitem("the_space_mod:sulfur_ingot", {
    description = "Sulfur ingot",
    inventory_image = "the_space_mod_sulfur_ingot.png"
})

core.register_craftitem("the_space_mod:titanium_ingot", {
    description = "Titanium ingot",
    inventory_image = "the_space_mod_titanium_ingot.png"
})
--machines
core.register_node("the_space_mod:electric_crafter", {
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
    output = "the_space_mod:sulfur_ingot",
    recipe = "the_space_mod:asteroid_sulfur_ore",
    cooktime = 10
})

core.register_craft({
    type = "cooking",
    output = "the_space_mod:titanium_ingot",
    recipe = "the_space_mod:asteroid_titanium_ore",
    cooktime = 10
})
-- atmosphere
atmosphere = {}
timer = 0

--memory cleaning
        core.register_on_leaveplayer(function(player, timed_out)
            atmosphere[player] = nil
        end)

core.register_globalstep(function(dtime)
    timer = timer + dtime
    local players = core.get_connected_players()
    if timer >= 3 then
        timer = 0
        
        --detect atmosphere
        for _, player in ipairs(players) do
            local pos = player:get_pos()
            --atmospheric layers
            if pos.y < 1000 and atmosphere[player] ~= 0 then
                atmosphere[player] = 0
                core.chat_send_all(atmosphere[player])
            end
            
        end
    end

end)
