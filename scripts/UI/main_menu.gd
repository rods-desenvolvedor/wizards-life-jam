extends CanvasLayer

@export var main_scene : PackedScene


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/introduction.tscn")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	pass # Replace with function body.
