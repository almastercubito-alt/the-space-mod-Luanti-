--items
core.register_craftitem("space_suits:gas_tank", {
    description = "Gas tank",
    inventory_image = "the_space_mod_gas_tank.png",
    stack_max = 1
})
core.register_craftitem("space_suits:oxigen_tank", {
    description = "Oxigen tank",
    inventory_image = "the_space_mod_oxigen_tank.png",
    stack_max = 1
})
-- alias
core.register_alias("space_core:gas_tank", "space_suits:gas_tank")
core.register_alias("gas_tank", "space_suits:gas_tank")
core.register_alias("space_core:presurized_helmet", "space_suits:presurized_helmet")
core.register_alias("presurized_helmet", "space_suits:presurized_helmet")
core.register_alias("space_core:oxigen_backpack", "space_suits:oxigen_backpack")
core.register_alias("oxigen_backpack", "space_suits:oxigen_backpack")
--suit

--orbital
armor:register_armor("space_suits:presurized_helmet", {
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

armor:register_armor("space_suits:oxigen_backpack", {
    description = "Oxigen backpack",
    inventory_image = "the_space_mod_oxigen_backpack_icon.png",
    texture = "the_space_mod_oxigen_backpack_2.png",
    preview = "",
    groups = {
        armor_torso = 1,
        armor_heal = 2,
        life_support= 1
    }
})
--moon

--life_support check
function space.has_life_support(player)
    local name = player:get_player_name()

    if not armor.textures[name] then
        return false
    end

    local texture = armor.textures[name].armor or ""

    local helmet = string.find(texture, "presurized_helmet")
    local backpack = string.find(texture, "oxigen_backpack")

    return helmet and backpack
end