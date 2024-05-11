extends CharacterBody2D


signal player_on_npc_area 
signal player_off_npc_area




func _on_area_2d_body_entered(body):
	player_on_npc_area.emit()


func _on_area_2d_body_exited(body):
	player_off_npc_area.emit()
