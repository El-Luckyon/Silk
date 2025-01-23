local Folder = script.Parent

export type Entity = {
    New : (EntityId : number) -> Entity,
    Id : number,
    BitMask : number,
    Components : {[number] : boolean?},
    HasComponent : (Entity, ComponentId : number) -> (number?),
    AddComponent : (Entity, ComponentId : number) -> (),
    RemoveComponent : (Entity, ComponentId : number) -> (),
}

local Entity = {} :: Entity
Entity.__index = Entity

function Entity.New(Id)
    local self = {}
    self.Id = Id
    self.Components = {}
    setmetatable(self, Entity)
end

function Entity:HasComponent(ComponentId)
    return self.Components[ComponentId]
end

function  Entity:AddComponent(ComponentId)
    self.Components[ComponentId] = true
end

function  Entity:RemoveComponent(ComponentId)
    self.Components[ComponentId] = nil
end

return Entity