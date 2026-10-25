# Mixin

A deep copying mixin utility for Luau with full type support and zero dependencies.

## Why?
Merge tables without writing `for` loops manually, with safe deep cloning and full autocomplete support out of the box.

## Quick Start
```lua
local Mixin = require(ReplicatedStorage.Packages.Mixin)

local A = { HP = 100, Speed = 10 }
local B = { HP = 50, Damage = 5 }

local C = Mixin(A, B)

C.HP -= 50

print(A.HP) -- 100, untouched because C is a deep copy, not a reference to A
print(C.HP) -- 0, because B overwrote A's HP
```

## Extra
Example of how Mixin can be used in OOP to replace inheritance with composition

```lua
local Mixin = require(ReplicatedStorage.Packages.Mixin)

local Animal = require("./Animal")

export type Type = Animal.Type & {
    Bark: (self: Type) -> (),
    IsAngry: boolean
}

local Dog = {} :: Type
Dog.IsAngry = false --Default properties here, mixin will copy them
Dog.IsHungry = true --Derived from Animal, overriding 

local Constructor = {}

function Constructor.new(): Type
    return Mixin(
        Animal.new(),
        Dog
    ) --No metatables used, copying everything from Animal and Dog
end

function Dog:Bark()
    print("Woof!")
end

return table.freeze(Constructor)
```

## Installation
Add to your wally.toml:
```
[dependencies]
Mixin = "pocketpremium/mixin@1.0.0"
```