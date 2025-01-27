local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Silk = require(ReplicatedStorage.Shared.Silk.Silk)

export type Transform = {
    Position : Vector3,
    Rotation : Vector3,
    Rotation2 : Vector3
}

export type Health = {
    Health : number,
    RegenRate : number,
}

export type Movement = {
    WalkSpeed : number,
    JumpHeight : number,
    SwimSpeed : number,
    SprintMultiplier : number,
    CrouchMultiplier : number,
}

local Transform : Transform = {
    Position = Vector3.zero,
    Rotation = Vector3.zero,
    Rotation2 = Vector3.zero,
}

local Health : Health = {
    Health = 100,
    RegenRate = 2,
}

local Movement : Movement = {
    WalkSpeed = 16,
    JumpHeight = 7.2,
    SwimSpeed = 10,
    SprintMultiplier = 1.5,
    CrouchMultiplier = 0.5,
}


Transform = Silk.Component("Transform", Transform)
Health = Silk.Component("Health", Health)
Movement = Silk.Component("Movement", Movement)

local World = Silk.World("Main-World")

local Tree = World:Entity(Transform)
local Tree2 = World:Entity(Transform)

local Chest = World:Entity(Transform, Health)
local Chest2 = World:Entity(Transform, Health)

local Chicken = World:Entity(Transform, Health, Movement)
local Chicken2 = World:Entity(Transform, Health, Movement)


print("Tree Has Health:", World:Check(Tree, Health))
print("Tree Has Movement:", World:Check(Tree, Movement))
print("Tree Has Transform:", World:Check(Tree, Transform))
print()
print("Chest Has Health:", World:Check(Chest, Health))
print("Chest Has Movement:", World:Check(Chest, Movement))
print("Chest Has Transform:", World:Check(Chest, Transform))
print()
print("Chicken Has Health:", World:Check(Chicken, Health))
print("Chicken Has Movement:", World:Check(Chicken, Movement))
print("Chicken Has Transform:", World:Check(Chicken, Transform))
