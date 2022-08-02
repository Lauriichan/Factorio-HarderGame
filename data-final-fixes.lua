require("lib")

data:extend({{
    type = "recipe-category",
    name = "deep-mine-2"
}})

data.raw["assembling-machine"]["deep-mine-2"].crafting_categories = {"deep-mine-2"};

for _,recipe in pairs(data.raw["recipe"]) do
    if recipe.category == "deep-mine" then
        if recipe.name ~= "deep-mining" then
            recipe.category = "deep-mine-2"
        else 
            recipe.enabled = true
        end
    end
end

local recipe = data.raw["recipe"]["deep-mine"];
recipe.ingredients = {
    {"electric-mining-drill", 1},
    {"stone-brick", 10},
    {"iron-plate", 5},
    {"iron-gear-wheel", 7},
    {"electronic-circuit", 3},
    {"iron-stick", 2}
}
recipe.enabled = true


data.raw["recipe"]["inserter"].ingredients = {
    {"burner-inserter", 1},
    {"electronic-circuit", 1}
}

local tech = data.raw["technology"]["deep-mine"]
tech.hidden = true
tech.enabled = true
tech = data.raw["technology"]["deep-mine-2"]
tech.unit = {
    count = 200,
    ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
    },
    time = 60
}
tech.prerequisites = {
    "speed-module",
    "mining-productivity-2"
}
local final_effect = nil
local tech_sample = {
    type = "technology",
    icon_size = 128,
    prerequisites = {"deep-mine-2"},
    unit = {
        count = 100,
        ingredients =
        {
            {"automation-science-pack", 2},
            {"logistic-science-pack", 2},
            {"chemical-science-pack", 1}
        },
        time = 30
    },
    order = "a"
}
for _,effect in pairs(tech.effects) do
    if effect.recipe == "deep-mine-2" then
        final_effect = effect
    else
        local rec = data.raw["recipe"][effect.recipe]
        local techc = table.deepcopy(tech_sample)
        techc.name = rec.name
        techc.localised_name = rec.localised_name
        if recipe.icons then
            techc.icons = rec.icons
        else
            techc.icon = rec.icon
        end
        techc.icon_size = rec.icon_size
        techc.effects = {effect}
        data:extend({techc})
    end
end
tech.effects = {final_effect}

---############################################################################
---local def = table.deepcopy(data.raw["furnace"]["stone-furnace"])
---for name,furnace in pairs(data.raw["furnace"]) do
---    if (table_contains(furnace.crafting_categories, "smelting")) then
---        local new_furnace = table.deepcopy(furnace)
---        new_furnace.type = "assembling-machine"
---        new_furnace.source_inventory_size = nil
---        data.raw.furnace[name] = nil
---        data:extend({new_furnace})
---    end
---end
---def.name = "invalid-furnace"
---data:extend({def})
---############################################################################