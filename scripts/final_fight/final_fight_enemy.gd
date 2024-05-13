extends CharacterBody2D


var speed : float = 65.0
var player : CharacterBody2D

var can_attack : bool = true
var attacking : bool = false

@onready var attack_timer : Timer = $AttackTimer
@onready var animation_controller : AnimationPlayer = $AnimationPlayer

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	if can_attack && attacking:
		player.health -= 10.0
		can_attack = false
		attack_timer.start()
		animation_controller.play("attack")
	
func _physics_process(delta):
	var dir : Vector2 = (player.position - position).normalized()
	position += dir * delta * speed


func _on_area_2d_body_entered(body):
	attacking = true


func _on_area_2d_body_exited(body):
	attacking = false


func _on_attack_timer_timeout():
	can_attack = true
