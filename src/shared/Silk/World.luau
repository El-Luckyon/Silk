local Folder = script.Parent

local EntityClass = require(Folder.Entity)

export type World = {
    New : (WorldId : string) -> World,
    Id : string,
    Archetypes : {},
    Entities : {EntityClass.Entity},
    Systems : {},
    LastEntityId : number,
    Entity : (World) -> number,
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

function World:System()
    
end


return World