extends Resource

@export_group("General")
@export var name:String = "genericName"
@export_multiline var description:String = "genericDescription"
@export var UISprite:Texture2D
@export var animation:SpriteFrames

@export_group("Stats")
@export var damageReduction = 0.0
@export var healthBonus = 0.0
