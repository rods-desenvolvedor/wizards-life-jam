extends CanvasLayer


@onready var color_controller : ColorRect = $Control/ColorRect
@onready var animation_controller : AnimationPlayer = $AnimationPlayer

var player : CharacterBody2D

func _ready():
	hide()
	player = get_tree().get_first_node_in_group("player")

func _on_player_player_died():
	show()
	animation_controller.play("player_dies")
