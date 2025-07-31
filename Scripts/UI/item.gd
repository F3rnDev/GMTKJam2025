extends Area2D


@export var imageItem:Texture2D
@export var amount:int
@export var type:EquipamentType.SlotType

func _ready() -> void:
	body_entered.connect(_add_item_inventory)

func _add_item_inventory(body) -> void:
	var data = {
		"imageItem": imageItem,
		"amount": amount,
		"slotType": type,
	}
	%UI.add_new_item(data)
	queue_free()
