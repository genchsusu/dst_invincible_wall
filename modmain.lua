GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

if GetModConfigData("enable_increased") then
    modimport("custom/recipes")
end

modimport("custom/components/absolute_guard")
modimport("custom/components/birdspawner")
modimport("custom/prefabs/walls")
modimport("custom/height_editor")

local entities = {
    "wall_hay",
    "wall_limestone",
    "wall_ruins",
    "wall_stone",
    "wall_wood",
}

Assets = {}

if GetModConfigData("enable_minimapicons") then
    for entities_count = 1, #entities do
        local entity = entities[entities_count]
        table.insert(Assets, Asset("IMAGE", "images/" .. entity .. ".tex"))
        table.insert(Assets, Asset("ATLAS", "images/" .. entity .. ".xml"))
        AddMinimapAtlas("images/" .. entity .. ".xml")
        AddPrefabPostInit(entity, function (inst)
            inst.entity:AddMiniMapEntity():SetIcon(inst.prefab .. ".tex")
        end)
    end
end
