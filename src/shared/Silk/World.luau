local Folder = script.Parent

local Components : {[string] : {["1"] : {any}, ["2"] : number}} = require(Folder.Components)

export type World = {
    New : (WorldId : string) -> World,
    Id : string,
    Archetypes : {},
    Entities : {[number] : boolean},
    Systems : {},
    Collection : {[number] : {any}},
    EntityIdToIndex : {[number] : number},
    LastEntityId : number,
    Entity : (World) -> number,
    Attach : (World, EntityId : number, Component : string) -> (),
    Detach : (World, EntityId : number, Component : string) -> (),
    Build : (World, EntityId : number, ...string) -> (),
    Kill : (World, EntityId : number) -> (),
}

local World = {} :: World
World.__index = World

local function EntityIdFromIndex(EntityIdToIndex, IndexToFind)
    for EntityId, Index in EntityIdToIndex do
        if Index == IndexToFind then
            return EntityId
        end
    end
end

function  World.New(WorldId)
    local self = {
        Id = WorldId,
        Archetypes = {},
        Entities = {},
        Collection = {},
        EntityIdToIndex = {},
        Systems = {},
        LastEntityId = 0,
    }

    setmetatable(self, World)
    return self
end

function World:Entity()
    self.LastEntityId += 1
    local NewEntityId = self.LastEntityId
    self.Entities[NewEntityId] = true
    return NewEntityId
end

function World:Attach(EntityId, ComponentName)
    local Component = Components[ComponentName]
    local ComponentId = Component[2]

    if not self.Collection[ComponentId] then
        self.Collection[ComponentId] = {}
        self.EntityIdToIndex[ComponentId] = {t = true}
    end

    table.insert(self.Collection[ComponentId], table.clone(Component[1]))
    local Index = #self.Collection[ComponentId]
    self.EntityIdToIndex[ComponentId][EntityId] = Index
end

function World:Build(EntityId, ...)
    local Components = {...}
    for i, Component in Components do
        self:Attach(EntityId, Component)
    end
end

function World:Detach(EntityId, ComponentName)
    local Component = Components[ComponentName]
    local ComponentId = Component[2]

    local Collection = self.Collection[ComponentId]
    local EntityIdToIndex = self.EntityIdToIndex[ComponentId]

    local Index = EntityIdToIndex[EntityId]

    if not Index then
        return
    end

    local LastIndex = #Collection

    if LastIndex == 1 then
        self.Collection[ComponentId] = nil
        self.EntityIdToIndex[ComponentId] = nil
        return
    end
    
    if Index == LastIndex then
        self.Collection[ComponentId][LastIndex] = nil
        self.EntityIdToIndex[ComponentId][EntityId] = nil
    else
        local LastEntityId = EntityIdFromIndex(EntityIdToIndex, LastIndex)
        
        self.Collection[ComponentId][Index] = Collection[LastIndex]
        self.EntityIdToIndex[ComponentId][LastEntityId] = Index
      
        self.EntityIdToIndex[ComponentId][EntityId] = nil
        self.Collection[ComponentId][LastIndex] = nil
    end
end

function World:Kill(EntityId)
    for ComponentName in Components do
        self:Detach(EntityId, ComponentName)
    end
    self.Entities[EntityId] = nil
end

function World:System()
    
end


return World