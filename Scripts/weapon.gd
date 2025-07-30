extends AnimatedSprite2D

@export var orbit_distance: float = 30.0 # Distância do player
@export var min_aim_distance: float = 30.0 # Distância mínima para mirar
var attacking = false

func _ready() -> void:
	play("idle")

func _process(delta: float) -> void:
	var mouse_global = get_global_mouse_position()
	var player_global = get_parent().global_position

	var direction = (mouse_global - player_global).normalized()
	global_position = player_global + direction * orbit_distance
	
	var offset = mouse_global - player_global
	var distance = offset.length()
	
	if distance > min_aim_distance:
		look_at(mouse_global)
	else:
		look_at(player_global + direction * 1000)
	
	var angle = direction.angle()
	flip_v = abs(angle) > PI / 2
	
	if Input.is_action_just_pressed("Attack"):
		Attack()

func Attack():
	attacking = true
	play("attack")

func _on_animation_finished() -> void:
	if animation == "attack":
		attacking = false
		play("idle")
