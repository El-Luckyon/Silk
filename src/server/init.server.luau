local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Silk = require(ReplicatedStorage.Shared.Silk.Silk)

export type Tranform = {
    Position : Vector3,
    Rotation : Vector3,
    Rotation2 : Vector3
}

export type Physics = {
    Acclertation : Vector3,
    Velocity : Vector3,
    Force : Vector3,
}

local Tranform : Tranform = {
    Position = Vector3.zero,
    Rotation = Vector3.zero,
    Rotation2 = Vector3.zero,
}

local Physics : Physics = {
    Acclertation = Vector3.zero,
    Velocity = Vector3.zero,
    Force = Vector3.zero,
}

debug.setmemorycategory("$ Components")

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

print("Created 10 Components In: ", os.clock() - StartTime)

local StartTime2 = os.clock()

debug.setmemorycategory("$ World")

local World = Silk.World("Test-World")

print("Created World In: ", os.clock() - StartTime2)

debug.setmemorycategory("$ Entities")

local StartTime3 = os.clock()

for i = 1, 10000 do
	local Entity = World:Entity()
    World:Build(Entity, 
        "Tranform",
        "Physics",
        "Physics1",
        "Physics2",
        "Physics3",
        "Physics4",
        "Physics5",
        "Physics6",
        "Physics7",
        "Physics8"
    )
end

print("Created 10,000 Entities In: ", os.clock() - StartTime3)

print("Benchmark Done In: ", os.clock() - StartTime)

task.wait(10)

local StartTime = os.clock()

for i = 1, 5000 do
	World:Kill(i)
end

print(World)
print("Killed 10,000 Entities In: ", os.clock() - StartTime)