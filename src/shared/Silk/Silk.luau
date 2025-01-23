local Folder = script.Parent
local WorldClass = require(Folder.World)
local ComponentClass = require(Folder.Component)

local Silk = {}

local Worlds = {}
local Components = require(Folder.Components)
local ComponentCount = 0

function Silk.World(WorldId : string)
    local World = Worlds[WorldId]

    if World then
        return World
    end

    World = WorldClass.New(WorldId)
    Worlds[WorldId] = World
    return World
end

function Silk.Component<Type>(Name : string, DataTemplate : Type)
    local Component = Components[Name]

    if Component then
        return Component
    end

    if not DataTemplate then
        warn(`[SILK] creating component without any data template, Name : {Name}`)
    end

    ComponentCount += 1
    Component = ComponentClass.New(DataTemplate, Name)
    Components[Name] = {Component, ComponentCount}
    
    return ComponentCount
end

return Silk
