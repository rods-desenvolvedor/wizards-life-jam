extends CharacterBody2D

@onready var attack_timer : Timer = $AttackTimer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var enemy_health_progress_bar : ProgressBar = $ProgressBar
@onready var audio_controller : AudioStreamPlayer2D = $AudioStreamPlayer2D

signal player_hit

var speed : float = 65.0
var health : float = 100.0

var player : CharacterBody2D
var chasing_player : bool = false
var attacking_player : bool = false
var can_attack : bool = true

func _ready():
	player = get_tree().get_first_node_in_group("player")
	enemy_health_progress_bar.value = 100.0

func _process(delta):
	
	enemy_health_progress_bar.value = health
	
	if health <= 0:
		VarGlobals.experience += 25.0
		queue_free()
		
	if chasing_player:
		var dir : Vector2 = (player.position - position).normalized()
		velocity = position.direction_to(player.position) * speed
		move_and_slide()
		
	if attacking_player && can_attack:
		audio_controller.play()
		player_hit.emit()
		animation_player.play("attack")
		player.health -= 10.0
		print(player.health)
		can_attack = false
		attack_timer.start()


func _on_area_2d_area_entered(area):
	if area.has_method("is_magic"):
		health -= VarGlobals.player_damage


func _on_chase_area_body_entered(body):
	chasing_player = true


func _on_chase_area_body_exited(body):
	chasing_player = false


func _on_attack_area_body_entered(body):
	attacking_player = true


func _on_attack_area_body_exited(body):
	attacking_player = false


func _on_attack_timer_timeout():
	can_attack = true


func _on_chase_area_area_entered(area):
	if area.has_method("is_magic"):
		chasing_player = true
