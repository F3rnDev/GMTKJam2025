extends Area2D

@export_file("*.tres") var itemID:String
@export var imageItem:Texture2D
@export var amount:int
@export var type:EquipamentType.SlotType

var stats:Resource

func _ready() -> void:
	body_entered.connect(_add_item_inventory)
	
	if type == EquipamentType.SlotType.WEAPON:
		stats = load(itemID)
		
	elif (type == EquipamentType.SlotType.HELMET or 
	type == EquipamentType.SlotType.UPPER or 
	type == EquipamentType.SlotType.LOWER):
		pass

func _add_item_inventory(body) -> void:
	var data = {
		"imageItem": imageItem,
		"amount": amount,
		"slotType": type,
		"stats": stats
	}
	%UIinventory.add_new_item(data)
	queue_free()
