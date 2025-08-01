extends Resource

class_name WeaponEquip

@export_group("General")
@export var name:String = "genericName"
@export_multiline var description:String = "genericDescription"
@export var sprite:Texture2D
@export var collisionSize: Vector2 = Vector2(10, 10)

@export_group("Stats")
@export var baseDamage = 1.0
@export var critChance = 5.0
@export var attackSpeed = 1.0
@export_enum("Melee", "Ranged") var weaponType = "Melee"
