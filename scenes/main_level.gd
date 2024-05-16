extends Node

var player : CharacterBody2D 

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	if player.health <= 0:
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
