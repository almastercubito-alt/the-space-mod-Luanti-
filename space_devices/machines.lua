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