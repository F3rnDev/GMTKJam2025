extends TileMapLayer

@onready var inventory = %UIinventory

func _process(delta: float) -> void:
	Inventory()

func Inventory():
	if Input.is_action_just_pressed("Inventory") and inventory.visible == true:
		inventory.visible = false
		print("Fecha inventário")
	elif Input.is_action_just_pressed("Inventory"):
		inventory.visible = true
		print("Abre inventário")
