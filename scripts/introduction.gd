extends Node

@onready var animation_controller : AnimationPlayer = $AnimationPlayer


func _ready():
	animation_controller.play("intro")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/first_scene.tscn")
