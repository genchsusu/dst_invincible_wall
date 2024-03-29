enable_light = GetModConfigData("enable_light")
enable_sanityaura = GetModConfigData("enable_sanityaura")
enable_lightningblocker = GetModConfigData("enable_lightningblocker")
enable_absolute_guard = GetModConfigData("enable_absolute_guard")
enable_bird_repellent = GetModConfigData("enable_bird_repellent")
enable_auto_door = GetModConfigData("enable_auto_door")


local function MakeObstaclePhysicsBlockAll(inst, rad, height)
    inst:AddTag("blocker")
    local phys = inst.entity:AddPhysics()
    phys:SetMass(0) -- Bullet wants 0 mass for static objects
    phys:SetCollisionGroup(COLLISION.CHARACTERS)
    phys:SetCollisionGroup(COLLISION.FLYERS)
    phys:SetCollisionGroup(COLLISION.GIANTS)
    phys:SetCollisionGroup(COLLISION.GROUND)
    phys:SetCollisionGroup(COLLISION.ITEMS)
    phys:SetCollisionGroup(COLLISION.OBSTACLES)
    phys:SetCollisionGroup(COLLISION.SMALLOBSTACLES)
    phys:SetCollisionGroup(COLLISION.WORLD)

    phys:ClearCollisionMask()
    phys:CollidesWith((TheWorld.has_ocean and COLLISION.GROUND) or COLLISION.WORLD)
    phys:CollidesWith(COLLISION.CHARACTERS)
    phys:CollidesWith(COLLISION.FLYERS)
    phys:CollidesWith(COLLISION.GIANTS)
    phys:CollidesWith(COLLISION.GROUND)
    phys:CollidesWith(COLLISION.ITEMS)
    phys:CollidesWith(COLLISION.OBSTACLES)
    phys:CollidesWith(COLLISION.SMALLOBSTACLES)
    phys:CollidesWith(COLLISION.WORLD)
    phys:SetCapsule(rad, height or 2)
    return phys
end

local function ModifyWallPrefab(inst)
    -- invincible
    MakeObstaclePhysicsBlockAll(inst, .5)
    if inst.components.health ~= nil then
        inst.components.health:SetAbsorptionAmount(1)
    end

    if inst.components.workable ~= nil then
        local old_Destroy = inst.components.workable.Destroy
        function inst.components.workable:Destroy(destroyer)
            if destroyer.components.playercontroller == nil then return end
            return old_Destroy(self,destroyer)
        end
    end
    -- invincible

    if enable_light then 
        inst.entity:AddLight()
        inst.Light:Enable(true)
        inst.Light:SetRadius(enable_light)
        inst.Light:SetFalloff(0.5)
        inst.Light:SetIntensity(0.8)
        -- inst.Light:SetColour(255 / 255, 230 / 255, 150 / 255)
        inst.Light:SetColour(223/255, 208/255, 69/255)

        inst:AddTag("daylight")
    end

    if enable_absolute_guard then
        inst:AddTag("absolute_guard")
        inst:AddTag("antlion_sinkhole_blocker")
        inst:AddTag("quake_blocker")
    end

    if enable_bird_repellent then
        inst:AddTag("drive_bird_scarecrow")
    end
    
    if enable_lightningblocker then
        inst:AddComponent("lightningblocker") 
        inst.components.lightningblocker:SetBlockRange(28)
    end

    if enable_sanityaura then
        inst:AddComponent("sanityaura")
        inst.components.sanityaura.aura = TUNING.SANITYAURA_SUPERHUGE
    end

    if enable_auto_door then
        inst:DoPeriodicTask(.1, function(inst)
            local x, y, z = inst.Transform:GetWorldPosition()
            local players = TheSim:FindEntities(x, y, z, 1.8, {"player"})
            local anims = {"broken", "onequarter", "half", "threequarter", "fullA", "fullB", "fullC"}

            if #players > 0 then
                if inst.Physics:IsActive() then
                    if not inst.savedAnimState then
                        for _, anim in ipairs(anims) do
                            if inst.AnimState:IsCurrentAnimation(anim) then
                                inst.savedAnimState = anim
                                break
                            end
                        end
                    end
                    inst.Physics:SetActive(false)
                    inst._ispathfinding:set(false)
                    inst.AnimState:PlayAnimation("broken")
                end
            else
                if not inst.Physics:IsActive() then
                    inst.Physics:SetActive(true)
                    inst._ispathfinding:set(true)
                    if inst.savedAnimState then 
                        inst.AnimState:PlayAnimation(inst.savedAnimState)
                        inst.savedAnimState = nil
                    end
                end
            end
        end)     
    end
end

local wall_types = {"hay", "wood", "stone", "moonrock", "ruins", "dreadstone"}

for _, wall_type in ipairs(wall_types) do
    AddPrefabPostInit("wall_"..wall_type, ModifyWallPrefab)
end