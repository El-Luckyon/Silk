local Folder = script.Parent
local WorldClass = require(Folder.World)

local Silk = {}

local Worlds = {}

function Silk.World(WorldId : string)
    local World = Worlds[WorldId]

    if World then
        return World
    end
    
    World = WorldClass.New(WorldId)
    Worlds[WorldId] = World
    return World
end

return Silk
