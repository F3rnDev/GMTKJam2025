extends Slot
@export var UIRef:Control

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Slot and data.slotType == slotType and data.imageItem != imageItem

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data == self: return
	
	if imageItem == data.imageItem:
		amount += data.amount
		data.set_empty_slot()
	else:
		var temp = property
		property = data.property
		data.property = temp
	
	UIRef.droppedEquipment.emit(data)

func set_empty_slot():
	imageItem = null
	amount = 0
	
	UIRef.droppedEquipment.emit(null)
