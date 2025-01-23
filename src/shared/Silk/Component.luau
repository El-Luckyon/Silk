local Folder = script.Parent

export type Component<Type> = {
    New : (DataTemplate : Type, Name : string) -> Component<Type>,
    Collection : {},
    EntityIdToIndex : {},
    Template : Type,
    AddEntity : (Component<Type>, EntityId : number) -> (),
    RemoveEntity : (Component<Type>, EntityId : number) -> (),
    HasEntity : (Component<Type>, EntityId : number) -> number,
}

local Component = {} :: Component<any>
Component.__index = Component

function Component.New<Type>(DataTemplate : Type, Name)
    local self = {}
    self.Name = Name
    self.Template = DataTemplate
    self.EntityIdToIndex = {}
    self.Collection = {}
    setmetatable(self, Component)
    return self
end

function Component:AddEntity(EntityId)
    table.insert(self.Collection, table.clone(self.Template)) 
    self.EntityIdToIndex[EntityId] = #self.Collection
end

function Component:RemoveEntity(EntityId)
    local Index = self.EntityIdToIndex[EntityId]
    local Collection = self.Collection
    local LastIndex = #Collection
    local LastEntityId = Collection[LastIndex]

    self.EntityIdToIndex[LastEntityId] = Index
    self.EntityIdToIndex[EntityId] = nil

    self.Collection[Index] = LastIndex
    self.Collection[LastIndex] = nil
end

function Component:HasEntity(EntityId)
    return self.EntityIdToIndex[EntityId]
end

return Component