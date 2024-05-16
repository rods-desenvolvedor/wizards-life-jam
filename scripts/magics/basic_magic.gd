extends Area2D

var speed : float = 100.0

var direction : Vector2 = Vector2.ZERO

@onready var magic_audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var magic_timer : Timer = $MagicTimer
var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	magic_audio.play()
	
func _physics_process(delta):
	position += direction * speed * delta


func set_magic(position : Vector2, targetPosition : Vector2):
	global_position = position
	direction = (targetPosition - position).normalized()
	rotation_degrees = rad_to_deg(position.angle_to_point(targetPosition))

func _on_area_entered(area):
	$AnimatedSprite2D.play("explode")
	collision_layer = 0
	collision_mask = 0
	#hide()
	await  get_tree().create_timer(0.5).timeout
	hide()

func _on_magic_timer_timeout():
	queue_free()
	
func is_magic():
	pass


func _on_body_entered(body):
	if body != player:
		speed = 0.0
		$AnimatedSprite2D.play("explode")
		collision_layer = 0
		collision_mask = 0
		#hide()
		await  get_tree().create_timer(0.5).timeout
		hide()
