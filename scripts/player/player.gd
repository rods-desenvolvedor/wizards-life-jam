extends CharacterBody2D

signal player_died

@onready var animation_controller : AnimatedSprite2D = $AnimatedSprite2D
@onready var health_progress_bar : ProgressBar = $CanvasLayer/Control/PlayerHealth
@onready var mana_progress_bar : ProgressBar = $CanvasLayer/Control/PlayerMana
@onready var player_effects_animation_controller : AnimationPlayer = $AnimationPlayer
@onready var death_timer : Timer = $DeathTimer
@onready var respawn_timer : Timer = $RespawnTimer


var speed : float = 100.0
var isShooting : bool = false
var talking : bool = false
var targetPosition : Vector2 = Vector2.ZERO
var shootDirection : Vector2 = Vector2.ZERO
var dead : bool = false
var intro_on : bool = true


var health : float = 100.0
var mana : float = 100.0


@export var basic_magic_scene : PackedScene

func _ready():
	print(str(VarGlobals.player_death_counts))
	dead = false
	health_progress_bar.value = 100.0
	mana_progress_bar.value = 100.0

func _process(delta):
	health_progress_bar.value = health
	mana_progress_bar.value = mana
	talking = Dialogic.VAR.on_dialogue
	

func _physics_process(delta):
	
	var direction : Vector2 = Vector2.ZERO
	
	die()
	
	if !talking && !dead:
		if Input.is_action_pressed("walk_left"):
			direction.x -= 1
		if Input.is_action_pressed("walk_right"):
			direction.x += 1
		if Input.is_action_pressed("walk_up"):
			direction.y -= 1
		if Input.is_action_pressed("walk_down"):
			direction.y += 1
		
		shoot()
		
		if direction.length() > 0:
			direction = direction.normalized()
		

		if velocity.length() > 0:
			animation_controller.play("walk")
			if velocity.x > 0:
				animation_controller.flip_h = false
			else:
				animation_controller.flip_h = true
		else:
			animation_controller.stop()
			
			
	velocity = direction * speed

	move_and_slide()
	
func die():
	if health <= 0 and !dead:
		dead = true
		VarGlobals.player_death_counts += 1
		death_timer.start()
		respawn_timer.start()
		$CollisionShape2D.disabled = true
		player_effects_animation_controller.play("die")
		player_died.emit()
		
func shoot():
	if Input.is_action_just_pressed("attack") && mana >= 5.0:
		if isShooting:
			return
		mana -= 5.0
		isShooting = true
		targetPosition = get_global_mouse_position()
		shootDirection = (targetPosition - global_position).normalized()
		
		var magic = basic_magic_scene.instantiate()
		magic.set_magic(global_position, targetPosition)
		get_parent().add_child(magic)
		await  get_tree().create_timer(0.2).timeout
		
		isShooting = false


func _on_basic_enemy_player_hit():
	player_effects_animation_controller.play("get_hit")


func _on_ghost_master_npc_player_talking():
	pass


func _on_death_timer_timeout():
	$CollisionShape2D.disabled = false
	dead = false


func _on_respawn_timer_timeout():
	if !intro_on:
		position = get_tree().get_first_node_in_group("start_pos").position
