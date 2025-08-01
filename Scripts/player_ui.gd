extends Control

# Called when the node enters the scene tree for the first time.
func setCurHealth(health):
	$Health.value = roundi(health)
	$Health/HBoxContainer/Health.text = str(roundi(health))

func setMaxHealth(maxHealth):
	$Health.max_value = roundi(maxHealth)
	$Health/HBoxContainer/MaxHealth.text = str(roundi(maxHealth))
