extends CharacterBody2D

const SPEED = 200.0

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")

func _physics_process(delta: float) -> void:
	movePlayer()
	FlipPlayer()

	move_and_slide()

func movePlayer():
	var directionX := Input.get_axis("Left", "Right")
	var directionY := Input.get_axis("Up", "Down")
	var direction := Vector2(directionX, directionY)
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2().move_toward(direction, SPEED)

func FlipPlayer():
	var weapon = $Weapon
	var direction = (weapon.global_position - global_position).normalized()
	var angle = direction.angle()

	$AnimatedSprite2D.flip_h = abs(angle) > PI / 2
