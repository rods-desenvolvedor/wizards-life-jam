extends Node


@export var enemy_scene : PackedScene

var player : CharacterBody2D 
var player_died : bool = false

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_mob_timer_timeout():
	
	var enemy : CharacterBody2D = enemy_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	enemy.position = mob_spawn_location.position
	
	add_child(enemy)

func _on_player_player_died():
	$AnimationPlayer.play("transition")
	await  get_tree().create_timer(7.5).timeout
	get_tree().change_scene_to_file("res://scenes/main_level.tscn")
	
	
