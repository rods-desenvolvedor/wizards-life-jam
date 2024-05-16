extends Node


@onready var shop_timer : Timer = $ShopTimer
@onready var player : CharacterBody2D = $Player
@export var enemy_scene : PackedScene

var status_open : bool = false

var day : int = 1

func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(delta):
	
	if Input.is_action_just_pressed("status"):
		status_open = true
		
	if status_open:
		get_tree().paused = true
		$PlayerStatus.show() 

func _on_simple_npc_player_on_npc_area():
	$SimpleShop.visible = true


func _on_simple_npc_player_off_npc_area():
	print("jogador saiu da area")


func _on_shop_timer_timeout():
	day += 1
	shop_timer.start()

func _on_mob_timer_timeout():
	var final_enemy : CharacterBody2D = enemy_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	final_enemy.position = mob_spawn_location.position
	
	add_child(final_enemy)


func _on_player_status_close_status():
	print("despausar")
	status_open = false
	get_tree().paused = false
	$PlayerStatus.hide()
