extends StaticBody2D



var player_on_door : bool = false
var player : CharacterBody2D 

func _ready():
	player = get_tree().get_first_node_in_group("player")
	$AnimatedSprite2D.play("close")


func _process(delta):
	if player_on_door:
		if Input.is_action_just_pressed("interact"):
			$AnimatedSprite2D.play("open")
			$CollisionShape2D.disabled = true

func _on_area_2d_body_entered(body):
	if body == player:
		player_on_door = true
