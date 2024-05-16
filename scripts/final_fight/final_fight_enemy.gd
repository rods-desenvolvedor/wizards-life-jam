extends CharacterBody2D


var speed : float
var player : CharacterBody2D
var health : float = 100.0

var can_attack : bool = true
var attacking : bool = false
var get_hit : bool = false

@onready var health_bar : ProgressBar = $ProgressBar
@onready var attack_timer : Timer = $AttackTimer
@onready var animation_controller : AnimationPlayer = $AnimationPlayer

func _ready():
	health_bar.value = 100.0
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	
	if can_attack && attacking:
		player.health -= 10.0
		can_attack = false
		attack_timer.start()
		animation_controller.play("attack")
	
	health_bar.value = health
	
	if health <= 0:
		queue_free()
	
func _physics_process(delta):
	if player.health > 0:
		var dir : Vector2 = (player.position - position).normalized()
		speed = randf_range(50.0, 120.0)
		#position += dir * speed * delta
		velocity = position.direction_to(player.position) * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		
func _on_area_2d_body_entered(body):
	attacking = true


func _on_area_2d_body_exited(body):
	attacking = false


func _on_attack_timer_timeout():
	can_attack = true


func _on_get_hit_area_area_entered(area):
	if area.has_method("is_magic"):
		animation_controller.play("get_hit")
		health -= 15.0
		#var dir : Vector2 = -(player.position - position).normalized()
		#position += dir * 0.2 * 100
		
