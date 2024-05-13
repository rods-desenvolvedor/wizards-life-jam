extends CharacterBody2D

@onready var animation_controller : AnimatedSprite2D = $AnimatedSprite2D
@onready var health_progress_bar : ProgressBar = $CanvasLayer/Control/PlayerHealth
@onready var mana_progress_bar : ProgressBar = $CanvasLayer/Control/PlayerMana
@onready var player_effects_animation_controller : AnimationPlayer = $AnimationPlayer


var speed : float = 100.0
var isShooting : bool = false
var targetPosition : Vector2 = Vector2.ZERO
var shootDirection : Vector2 = Vector2.ZERO

var money : float = 100.0
var experience : float = 0.0
var health : float = 100.0
var mana : float = 100.0
var player_death_count : int


var health_potion : int = 0
var mana_potion : int = 0

var inventory = {
	"health_potion" : 0,
	"mana_potion" : 0
}


@export var basic_magic_scene : PackedScene

func _ready():
	
	print(str(player_death_count))
	health_progress_bar.value = 100.0
	mana_progress_bar.value = 100.0

func _process(delta):
	Dialogic.VAR.death_count = player_death_count 
	health_progress_bar.value = health
	mana_progress_bar.value = mana
	

func _physics_process(delta):
	
	
	var direction : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("walk_left"):
		direction.x -= 1
	if Input.is_action_pressed("walk_right"):
		direction.x += 1
	if Input.is_action_pressed("walk_up"):
		direction.y -= 1
	if Input.is_action_pressed("walk_down"):
		direction.y += 1
	
	shoot()
	die()

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
	if health <= 0:
		position = get_tree().get_first_node_in_group("start_pos").position
		health = 100.0
		mana += 10.0
		player_death_count += 1
	

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
