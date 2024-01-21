GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

if GetModConfigData("enable_increased") then
    modimport("custom/recipes")
end
modimport("custom/components/absolute_guard")
modimport("custom/components/birdspawner")
modimport("custom/prefabs/walls")
