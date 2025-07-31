extends CharacterBody2D

const SPEED = 200.0

func _ready() -> void:
	$ProgressBar.max_value = $Weapon/WeaponCoolDown.wait_time
	$ProgressBar.value = 0.0

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")
	
	FlipSprite()
	
	if !$Weapon/WeaponCoolDown.is_stopped():
		$ProgressBar.visible = true
		$ProgressBar.value = $Weapon/WeaponCoolDown.wait_time - $Weapon/WeaponCoolDown.time_left
	else:
		$ProgressBar.visible = false

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

func FlipSprite():
	var mouse = get_global_mouse_position()
	var direction = (mouse - global_position).normalized()
	var angle = direction.angle()

	$AnimatedSprite2D.flip_h = abs(angle) > PI / 2
