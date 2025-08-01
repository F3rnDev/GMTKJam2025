extends Control

@export var container : GridContainer

var inventorySpace:int = 20

@warning_ignore("unused_signal")
signal droppedEquipment(slot)


func add_new_item(data: Dictionary)->void:
	for slot in container.get_children():
		if slot.imageItem == null:
			slot.property = data
			if inventorySpace > 0:
				inventorySpace -= 1
			return
