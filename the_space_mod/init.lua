--blocks
core.register_node("the_space_mod:regolith", {
    description = "Lunar Regolith",
    tiles = {"regolith.png"},
    groups = {craky = 4}

})

core.register_node("the_space_mod:lunar_gravel", {
    description = "Lunar Gravel",
    tiles = {"lunargravel.png"},
    groups = {craky = 4}

})

core.register_node("the_space_mod:lunar_stone", {
    description = "Lunar Stone",
    tiles = {"lunarstone.png"},
    groups = {craky = 4}
})

core.register_node("the_space_mod:station_center", {
    description = "Station Center",
    tiles = {"station_center.png"}
})
--alias
core.register_alias("regolith", "the_space_mod:regolith")
core.register_alias("station_center", "the_space_mod:station_center")
core.register_alias("lunar_gravel", "the_space_mod:lunar_gravel")
core.register_alias("lunar_stone", "the_space_mod:lunar_stone")
core.register_alias("gas_tank", "the_space_mod:gas_tank")
core.register_alias("electric_crafter", "the_space_mod:electric_crafter")
-- items
core.register_craftitem("the_space_mod:gas_tank", {
    description = "Gas Tank",
    inventory_image = "the_space_mod_gas_tank.png"
})

--machines
core.register_node("the_space_mod:electric_crafter", {
    description = "Electric Crafter",
    tiles = {"electric_crafter_up.png", -- y+
    "electric_crafter_sides.png", -- y-
    "electric_crafter_sides.png", -- x+
    "electric_crafter_sides.png", -- x-
    "electric_crafter_sides.png", -- z+
    "electric_crafter_front.png"},-- z-
    groups = {craky=3, stone=1}
})