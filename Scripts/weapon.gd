extends AnimatedSprite2D

@export var orbit_distance: float = 30.0 # Distância do player
@export var min_aim_distance: float = 30.0 # Distância mínima para mirar

var attacking = false
@export var arc_angle: float = PI  # 90 graus de arco
var direction = Vector2.RIGHT
var arc_timer = 0.0
var arc_total_time = 0.0
var arc_start_angle = 0.0
var arc_end_angle = 0.0
@export var attack_duration: float = 0.15

func _ready() -> void:
	play("idle")

func _process(delta: float) -> void:
	if !attacking:
		setPosition()
	else:
		attack_arc_update(delta)
	
	if Input.is_action_just_pressed("Attack"):
		Attack()

func setPosition():
	var mouse_global = get_global_mouse_position()
	var player_global = get_parent().global_position
	
	var direction = (mouse_global - player_global).normalized()
	var targetPos = player_global + direction * orbit_distance
	global_position = lerp(global_position, targetPos, attack_duration)
	
	var offset = mouse_global - player_global
	var distance = offset.length()
	
	if distance > min_aim_distance:
		look_at(mouse_global)
	else:
		look_at(player_global + direction * 1000)
	
	var angle = direction.angle()
	flip_v = abs(angle) > PI / 2

func Attack():
	#$Strike.visible = true
	#$Strike.play("idle")
	attacking = true
	arc_timer = 0.0
	arc_total_time = attack_duration

	# Ângulo inicial e final do arco
	var player_pos = get_parent().global_position
	var to_mouse = (get_global_mouse_position() - player_pos).normalized()
	arc_start_angle = to_mouse.angle() - arc_angle / 2
	arc_end_angle = arc_start_angle + arc_angle

func _on_strike_animation_finished() -> void:
	attacking = false

func attack_arc_update(delta: float):
	arc_timer += delta
	var t = clamp(arc_timer / arc_total_time, 0, 1)

	# Interpolação do ângulo
	var eased_t = ease(t, attack_duration*2.0)  # Quanto maior, mais lento no início
	var angle = lerp(arc_start_angle, arc_end_angle, eased_t)

	# Atualiza posição ao redor do player
	var player_pos = get_parent().global_position
	var targetPos = player_pos + Vector2(cos(angle), sin(angle)) * orbit_distance
	global_position = targetPos

	# Rotaciona a faca para sempre apontar no sentido do arco
	look_at(player_pos + Vector2(cos(angle), sin(angle)) * 1000)

	# Flip visual
	flip_v = abs(angle) > PI / 2

	if t >= 1.0:
		attacking = false
		$Strike.visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if attacking:
		print("AYO FUCK EVE")
