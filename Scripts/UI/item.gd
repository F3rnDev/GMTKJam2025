extends Area2D

@onready var inventory: Control = %UIinventory

@export var imageItem:Texture2D
@export var amount:int
@export var type:EquipamentType.SlotType

func _ready() -> void:
	body_entered.connect(_add_item_inventory)

func _add_item_inventory(body) -> void:
	if inventory.inventorySpace > 0:
		var data = {
			"imageItem": imageItem,
			"amount": amount,
			"slotType": type,
		}
		%UIinventory.add_new_item(data)
		queue_free()
		
