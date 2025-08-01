extends Slot

@export var inventory:Control

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Slot and data.slotType == slotType

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data == self:
		return
	
	var temp = property
	property = data.property
	data.property = temp
	
	inventory.inventorySpace += 1

func set_empty_slot():
	imageItem = null
	amount = 0
	inventory.inventorySpace -= 1
