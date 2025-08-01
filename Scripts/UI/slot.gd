@tool
extends Control
class_name Slot

@export var slotType:EquipamentType.SlotType

var stats:Resource

@export var imageItem:Texture2D:
	set(value):
		imageItem = value
		property.imageItem = imageItem
		get_node("Image").texture = imageItem

@export var amount:int:
	set(value):
		amount = value
		property.amount = amount
		get_node("Amount").text = str(amount)
		get_node("Amount").visible = amount > 1

@onready var property:Dictionary = {
	"imageItem": imageItem,
	"amount": amount,
	"slotType": slotType,
	"stats": stats
}:
	set(value):
		property = value
		if property.amount >= 1:
			imageItem = property.imageItem
			amount = property.amount
			slotType = property.slotType
			stats = property.stats
		else:
			set_empty_slot()

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data = self.duplicate()
	
	data.scale = Vector2.ONE * 1.5
	data.get_node("Background").hide()
	data.get_node("Amount").hide()
	data.get_node("Image").position = -data.size / 2
	
	set_drag_preview(data)
	
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Slot

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data == self: return
	
	if imageItem == data.imageItem:
		amount += data.amount
		data.set_empty_slot()
	else:
		var temp = property
		property = data.property
		data.property = temp

func set_empty_slot():
	imageItem = null
	amount = 0
