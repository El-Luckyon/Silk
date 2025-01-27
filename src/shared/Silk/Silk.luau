--!strict
--!native
--!optimize 2

export type Component<Type> = {
    Data : Type,
    MaskLevel : number,
}

export type World = {
    Id : string,
    Entity : (World, ...any) -> number,
    LastEntityId : number,
    Entities : {number : {number}},
    Check : (World, number, number) -> boolean,
}

local Components : {[number] : Component<any>} = {}
local ComponentIdFromName : {[string] : number} = {}
local LastExponent = 0
local MaskLevel = 1
local Worlds = {}

local DebugMode = true

--//Utils
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

--//Components
local function FindComponent(Name : string) : (Component<any>?, number?)
    local Id = ComponentIdFromName[Name]
    if not Id then return end
    return Components[Id], Id
end

local function GetMaskFromMaskArray(MaskArray : {number}, ComponentId : number) : number
    return MaskArray[Components[ComponentId].MaskLevel]
end

local function CreateComponent<Type>(Name : string, Data : Type) : number
    local Component, ComponentId = FindComponent(Name)
    if Component then
        return ComponentId :: number
    end
    
    LastExponent += 1
    if LastExponent > 31 then
        LastExponent = 0
        MaskLevel += 1
    end

    local NewComponentId = 2 ^ LastExponent
    Components[NewComponentId] = {Data = Data, MaskLevel = MaskLevel} :: Component<Type>
    ComponentIdFromName[Name] = NewComponentId

    DebugInfo("Created Component, ComponentId :", NewComponentId, "Name:", Name)
    return NewComponentId
end

--//Component Masks
local function CreateComponentMasks(ComponentIds)
    local MaskArray = table.create(MaskLevel, 0)
    for i, Id in ComponentIds do
        local Component = Components[Id]
        local MaskIndex = Component.MaskLevel
        MaskArray[MaskIndex] = bit32.bor(MaskArray[MaskIndex], Id)
    end
    return MaskArray
end

local function MaskHasComponent(Mask : number, ComponentId : number)
    return bit32.band(Mask, ComponentId) > 0
end

--//Archetype
local function GenerateKey(Masks)
    local Key = 0
    for i, Mask in Masks do
        Key = bit32.bxor(Key, Mask)
    end
    return Key
end
local function AddEntityToArchetype()
    
end

local function CreateArchetype(World, Masks : {number})
    print("Archetype Key:", GenerateKey(Masks))
end


--//Entity
local function CreateEntity(World : World, ...:number)
    World.LastEntityId += 1
    local LastEntityId = World.LastEntityId
    local ComponentIds = {...}
    local ComponentMasks = CreateComponentMasks(ComponentIds)
    World.Entities[LastEntityId] = ComponentMasks
    DebugInfo("Created Entitiy, World :", World.Id, "EntityId:", LastEntityId)
    CreateArchetype(World, ComponentMasks)
    return LastEntityId
end

local function EntityHasComponent(World, EntityId : number, ComponentId : number) : boolean
    local ComponentMask = GetMaskFromMaskArray(World.Entities[EntityId], ComponentId)
    return MaskHasComponent(ComponentMask, ComponentId)
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
        Archetypes = {},
        Check = EntityHasComponent,
        Id = WorldId,
    }
    World[WorldId] = World
    return World :: World
end

local Silk = {}

Silk.World = CreateWorld
Silk.Component = CreateComponent
Silk.DebugInfo = DebugInfo

return Silk