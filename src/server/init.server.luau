local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Silk = require(ReplicatedStorage.Shared.Silk.Silk)

export type Tranform = {
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

local Tranform : Tranform = {
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

Tranform = Silk.Component("Transform", Tranform)
Health = Silk.Component("Health", Health)
Movement = Silk.Component("Movement", Movement)

local World = Silk.World("Main-World")

local Tree = World:Entity(Tranform)
local Chest = World:Entity(Tranform, Health)
local Chicken = World:Entity(Tranform, Health, Movement)

print("Tree Has Health:", World:Check(Tree, Health))
print("Tree Has Movement:", World:Check(Tree, Movement))
print("Tree Has Transform:", World:Check(Tree, Tranform))
print()
print("Chest Has Health:", World:Check(Chest, Health))
print("Chest Has Movement:", World:Check(Chest, Movement))
print("Chest Has Transform:", World:Check(Chest, Tranform))
print()
print("Chicken Has Health:", World:Check(Chicken, Health))
print("Chicken Has Movement:", World:Check(Chicken, Movement))
print("Chicken Has Transform:", World:Check(Chicken, Tranform))
