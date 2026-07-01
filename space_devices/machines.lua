--alias
core.register_alias("electric_crafter", "space_devices:electric_crafter")
core.register_alias("space_core:electric_crafter", "space_devices:electric_crafter")

--blocks

core.register_node("space_devices:electric_crafter", {
    description = "Electric crafter",
    tiles = {
        "electric_crafter_up.png",    -- Up (+Y)
        "electric_crafter_sides.png", -- Down (-Y)
        "electric_crafter_sides.png", -- Right (+X)
        "electric_crafter_sides.png", -- Left (-X)
        "electric_crafter_sides.png", -- Back (+Z)
        "electric_crafter_front.png"  -- Front (-Z)
    },
    groups = {cracky = 2},

    paramtype2 = "4dir",
    on_place = core.rotate_node
})

core.register_node("space_devices:oxigen_compressor",
{
    description = "Oxigen compressor",
    tiles = {"oxigen_compressor.png"},
    groups = {cracky = 2},

    --gas fill function
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if space.get_layer(clicker) == 0 then
            if itemstack:get_name() == "space_suits:gas_tank" then
                itemstack:replace("space_suits:oxigen_tank 1")

                return itemstack
            end
        end
        core.chat_send_player(clicker:get_player_name(), "Only can refill gas tanks in the earth surface")
    end

}
)