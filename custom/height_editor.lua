local AddAdminRPCHandler = function(mod, name, func)
    local newfunc = function(player, ...)
        if TheNet:GetClientTableForUser(player.userid).admin then
            func(player, ...)
        end
    end
    AddModRPCHandler(mod, name, newfunc)
end

local function IsActive()
    if ThePlayer ~= nil and TheFrontEnd and TheFrontEnd:GetActiveScreen().name == "HUD" then
        return true
    end
    return false
end

-- 调整高度
local function AdjustWallHeight(inst, increase)
    if inst.components.health ~= nil then
        local current_threshold = inst.components.health:GetPercent()
        local thresholds = {0, 0.4, 0.5, 0.99, 1}
        local thresholds_reverse = {1, 0.99, 0.5, 0.4, 0}
        local new_threshold = current_threshold

        if increase then
            for _, threshold in ipairs(thresholds) do
                if threshold > current_threshold then
                    new_threshold = threshold
                    break
                end
            end
        else
            for _, threshold in ipairs(thresholds_reverse) do
                if threshold < current_threshold then
                    new_threshold = threshold
                    break
                end
            end
        end

        inst.components.health:SetPercent(new_threshold)
    end
end

-- 增加墙的高度RPC事件
AddAdminRPCHandler(modname, "Wall_Height_Increase", function(inst)
    local ent = TheInput:GetWorldEntityUnderMouse()
    if ent ~= nil and ent:HasTag("wall") then
        AdjustWallHeight(ent, true)
    end
end)

-- 降低墙的高度RPC事件
AddAdminRPCHandler(modname, "Wall_Height_Decrease", function(inst)
    local ent = TheInput:GetWorldEntityUnderMouse()
    if ent ~= nil and ent:HasTag("wall") then
        AdjustWallHeight(ent, false)
    end
end)

-- RSHIFT+UP: 增加墙的高度
TheInput:AddKeyDownHandler(KEY_PAGEUP, function()
    if IsActive() and TheNet:GetIsServerAdmin() and TheInput:IsKeyDown(KEY_RSHIFT) then
        SendModRPCToServer(MOD_RPC[modname]["Wall_Height_Increase"])
    end
end)

-- RSHIFT+DOWN: 降低墙的高度
TheInput:AddKeyDownHandler(KEY_PAGEDOWN, function()
    if IsActive() and TheNet:GetIsServerAdmin() and TheInput:IsKeyDown(KEY_RSHIFT) then
        SendModRPCToServer(MOD_RPC[modname]["Wall_Height_Decrease"])
    end
end)
