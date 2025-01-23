local Folder = script.Parent

local EntityClass = require(Folder.Entity)
local ComponentClass = require(Folder.Component)
local Components : {[string] : {["1"] : ComponentClass.Component<any>, ["2"] : number}} = require(Folder.Components)

export type World = {
    New : (WorldId : string) -> World,
    Id : string,
    Archetypes : {},
    Entities : {EntityClass.Entity},
    Systems : {},
    LastEntityId : number,
    Entity : (World) -> number,
    Attach : (World, EntityId : number, Component : string) -> ()
}

local World = {} :: World
World.__index = World

function  World.New(WorldId)
    local self = {
        Id = WorldId,
        Archetypes = {},
        Entities = {},
        Systems = {},
        LastEntityId = 0,
    }

    setmetatable(self, World)
    return self
end

function World:Entity()
    self.LastEntityId += 1
    local NewEntityId = self.LastEntityId
    local Entity = EntityClass.New(NewEntityId)
    self.Entities[NewEntityId] = Entity
    return NewEntityId
end

function World:Attach(EntityId, ComponentId)
    local Entity = self.Entities[EntityId]
    local Component = Components[ComponentId]
    Component[1]:AddEntity(EntityId)
    Entity:AddComponent(Component[2])
end

function World:System()
    
end


return World