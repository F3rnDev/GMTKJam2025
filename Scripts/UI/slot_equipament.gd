extends Slot

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Slot and data.slotType == slotType and data.imageItem != imageItem
