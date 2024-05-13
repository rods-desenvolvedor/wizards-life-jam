extends Node2D


var player : CharacterBody2D 
var player_on_area : bool = false
func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	if player_on_area:
		if Input.is_action_just_pressed("interact"):
			Dialogic.start("test")

func _on_area_2d_body_entered(body):
	if body == player:
		player_on_area = true

func _on_area_2d_body_exited(body):
	pass # Replace with function body.
