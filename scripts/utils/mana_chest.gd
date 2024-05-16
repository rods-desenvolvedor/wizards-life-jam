extends AnimatedSprite2D

var player : CharacterBody2D 
var player_on_chest : bool = false
var opened : bool = false


func _ready():
	player = get_tree().get_first_node_in_group("player")
	play("closed")
	
func _process(delta):
	if player_on_chest && !opened:
		if Input.is_action_just_pressed("interact"):
			open_chest()

func _on_area_2d_body_exited(body):
	if body == player:
		player_on_chest = false
		
func _on_area_2d_body_entered(body):
	if body == player:
		player_on_chest = true

func open_chest():
	
	play("opened")
	
	var item : int = randi_range(1, 2)
	if item == 1:
		player.health += 10.0
	elif item == 2:
		player.mana += 10.0
		
	opened = true
		



