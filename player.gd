extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	movePlayer()

	move_and_slide()

func movePlayer():
	var directionX := Input.get_axis("Left", "Right")
	var directionY := Input.get_axis("Up", "Down")
	var direction := Vector2(directionX, directionY)
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2().move_toward(direction, SPEED)
