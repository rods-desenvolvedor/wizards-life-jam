extends Area2D

var speed : float = 200.0

var direction : Vector2 = Vector2.ZERO

@onready var magic_audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var magic_timer : Timer = $MagicTimer


func _ready():
	magic_audio.play()
	
func _physics_process(delta):
	position += direction * speed * delta


func set_magic(position : Vector2, targetPosition : Vector2):
	global_position = position
	direction = (targetPosition - position).normalized()
	rotation_degrees = rad_to_deg(position.angle_to_point(targetPosition))

func _on_area_entered(area):
	$CollisionShape2D.disabled
	hide()


func _on_magic_timer_timeout():
	queue_free()
