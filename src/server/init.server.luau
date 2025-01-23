local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Silk = require(ReplicatedStorage.Shared.Silk.Silk)

export type Tranform = {
    Position : Vector3,
    Rotation : Vector3,
}

export type Physics = {
    Acclertation : Vector3,
    Velocity : Vector3,
    Force : Vector3,
}

local Tranform : Tranform = {
    Position = Vector3.zero,
    Rotation = Vector3.zero
}

local Physics : Physics = {
    Acclertation = Vector3.zero,
    Velocity = Vector3.zero,
    Force = Vector3.zero,
}

debug.setmemorycategory("$ TEST")
local StartTime = os.clock()

Silk.Component("Tranform", Tranform)
Silk.Component("Physics", Physics)
Silk.Component("Physics1", Physics)
Silk.Component("Physics2", Physics)
Silk.Component("Physics3", Physics)
Silk.Component("Physics4", Physics)
Silk.Component("Physics5", Physics)
Silk.Component("Physics6", Physics)
Silk.Component("Physics7", Physics)
Silk.Component("Physics8", Physics)
Silk.Component("Physics9", Physics)

local World = Silk.World("Test-World")

local Entities = {}

for i = 1, 10000 do
    Entities[i] = World:Entity()
    World:Attach(Entities[i], "Tranform")
    World:Attach(Entities[i], "Physics")
    World:Attach(Entities[i], "Physics1")
    World:Attach(Entities[i], "Physics2")
    World:Attach(Entities[i], "Physics3")
    World:Attach(Entities[i], "Physics4")
    World:Attach(Entities[i], "Physics5")
    World:Attach(Entities[i], "Physics6")
    World:Attach(Entities[i], "Physics7")
    World:Attach(Entities[i], "Physics8")
    World:Attach(Entities[i], "Physics9")
end

print("Created 10k Entities With 10 Components In:", os.clock() - StartTime)


