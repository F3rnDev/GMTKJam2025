extends Control

@onready var container: GridContainer = $Inventory/GridContainer

func add_new_item(data: Dictionary) ->void:
	for slot in container.get_children():
		if slot.imageItem == data.imageItem:
			slot.amount += data.amount
			return
	
	for slot in container.get_children():
		if slot.imageItem == null:
			slot.property = data
			return
	
