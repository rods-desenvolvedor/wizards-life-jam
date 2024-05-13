extends Area2D


@onready var fence_controller : Node2D = $Fence
@onready var fence_collider : StaticBody2D = $StaticBody2D
@onready var mob_timer : Timer = $"../MobTimer"
var player : CharacterBody2D 


func _ready():
	player = get_tree().get_first_node_in_group("player")
	fence_controller.hide()
	fence_collider.collision_layer = 0


func _on_body_entered(body):
	if body == player:
		fence_controller.show()
		fence_collider.collision_layer = 1
		mob_timer.start()
