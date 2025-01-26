--!native
--!optimize 2
--!strict
local Components = {}
local LastExponent = 0
local Worlds = {}

local DebugMode = true

local function DebugInfo(...)
    if DebugMode then
        print("[SILK][DEBUG][INFO]", ...)
    end
end

local function DebugWarn(...)
    if DebugMode then
        warn("[SILK][DEBUG][WARN]", ...)
    end
end

local function CreateComponentMask(ComponentIds : {number})
    local Mask = 0
    for i, Id in ComponentIds do
        Mask = bit32.bor(Mask, Id)
    end
    return Mask
end

local function MaskHasComponent(Mask : number, ComponentId : number)
    return bit32.band(Mask, ComponentId) > 0
end

local function GetComponentsFromMask(Mask : number)

end

local function FindComponent(Name : string)
    return Components[Name]
end

local function CreateComponent<Type>(Name : string, Data : Type)
    local Component = FindComponent(Name)
    if Component then
        return Component[2]
    end
    LastExponent += 1
    local ComponentId = 2 ^ LastExponent
    Component = {Data, ComponentId}
    Components[Name] = Component
    return ComponentId
end

local function CreateEntity(World, ...:number)
    World.LastEntityId += 1
    local LastEntityId = World.LastEntityId
    local ComponentIds = {...}
    local ComponentMask = CreateComponentMask(ComponentIds)
    World.Entities[LastEntityId] = ComponentMask
    DebugInfo("Created Entitiy, World :", World.Id, "EntityId:", LastEntityId)
    return LastEntityId
end

local function EntityHasComponent(World, EntityId : number, ComponentId : number)
    local ComponentMask = World.Entities[EntityId]
    return MaskHasComponent(ComponentMask, ComponentId)
end

local function  CreateSystem()
    
end

local function CreateWorld(WorldId)
    local World = Worlds[WorldId]
    if World then
        return World
    end
    World = {
        LastEntityId = 0,
        Entity = CreateEntity,
        Entities = {},
        Check = EntityHasComponent,
        Id = WorldId,
    }  
    World[WorldId] = World
    return World
end

local Silk = {}

Silk.World = CreateWorld
Silk.Component = CreateComponent

return Silk