extends CharacterBody2D

@onready var inventory: Control = %UIinventory

const SPEED = 200.0

var health = 10.0
var stunned = false

var knockback_velocity = Vector2.ZERO
@export var knockback_strength: float = 200.0
@export var knockback_duration: float = 0.2
var knockback_timer = 0.0

@onready var popupDamage:PackedScene = preload("res://Nodes/damage_popup.tscn")


func _ready() -> void:
	$ProgressBar.max_value = $Weapon/WeaponCoolDown.wait_time
	$ProgressBar.value = 0.0

func _process(delta: float) -> void:
	Inventory()
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
	if knockback_timer > 0:
		knockback_timer -= delta
		velocity = knockback_velocity
	else:
		velocity = Vector2.ZERO
	
	if !stunned:
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

func receiveDamage(amount, source_position):
	if stunned:
		return
	
	stunned = true
	$Stun.start()
	
	#KnockBack
	var direction = (global_position - source_position).normalized()
	knockback_velocity = direction * knockback_strength
	knockback_timer = knockback_duration
	
	health -= amount
	
	if health <= 0:
		die()
	
	$HitEffect.play("hit")
	
	var instantiatePopup = popupDamage.instantiate()
	instantiatePopup.position = $DamageLocation.global_position
	instantiatePopup.get_child(0).text = str(amount)
	
	var tween = get_tree().create_tween()
	tween.tween_property(instantiatePopup, "position", global_position + getRandomDir(), 0.75)
	
	get_tree().current_scene.add_child.call_deferred(instantiatePopup)

func getRandomDir():
	return Vector2(randf_range(-1, 1), -randf()) * 16

func die():
	queue_free()

func _on_stun_timeout() -> void:
	stunned = false

func Inventory():
	if Input.is_action_just_pressed("Inventory") and inventory.visible == true:
		inventory.visible = false
	elif Input.is_action_just_pressed("Inventory"):
		inventory.visible = true
