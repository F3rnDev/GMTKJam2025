extends CharacterBody2D

@onready var popupDamage:PackedScene = preload("res://Nodes/damage_popup.tscn")

const SPEED = 50.0
@export var playerRef:CharacterBody2D
@export var health = 10

var stunned = false

var knockback_velocity = Vector2.ZERO
@export var knockback_strength: float = 200.0
@export var knockback_duration: float = 0.2

var knockback_timer = 0.0

func _ready() -> void:
	$ProgressBar.max_value = health
	$ProgressBar.value = health

func _process(delta: float) -> void:
	var target_position = playerRef.global_position
	var direction = target_position - global_position
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = true if direction.x < 0 else false
	
	if stunned:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.modulate.a = 0.5
	else:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.modulate.a = 1.0

func _physics_process(delta: float) -> void:
	if knockback_timer > 0:
		knockback_timer -= delta
		velocity = knockback_velocity
	else:
		velocity = Vector2.ZERO
	
	if !stunned:
		var target_position = playerRef.global_position
		global_position = global_position.move_toward(target_position, SPEED * delta)
		
	move_and_slide()

func receiveDamage(amount):
	if stunned:
		return
	
	stunned = true
	$Stun.start()
	
	health -= amount
	
	# Knockback
	var direction = (global_position - playerRef.global_position).normalized()
	knockback_velocity = direction * knockback_strength
	knockback_timer = knockback_duration
	
	if health <= 0:
		die()
	
	$ProgressBar.value = health
	
	var instantiatePopup = popupDamage.instantiate()
	instantiatePopup.position = $DamageLocation.global_position
	instantiatePopup.get_child(0).text = str(amount)
	
	var tween = get_tree().create_tween()
	tween.tween_property(instantiatePopup, "position", global_position + getRandomDir(), 0.75)
	
	get_tree().current_scene.add_child(instantiatePopup)

func getRandomDir():
	return Vector2(randf_range(-1, 1), -randf()) * 16

func die():
	queue_free()

func _on_stun_timeout() -> void:
	stunned = false
