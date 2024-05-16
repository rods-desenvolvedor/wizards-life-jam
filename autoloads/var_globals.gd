extends Node


var player_death_counts : int = 0
var experience : float = 0.0
var level : int = 1
var level_gap : float = 1.0
var experience_required : float = 100.0
var player_damage : float = 15.0


func _process(delta):
	Dialogic.VAR.death_count = player_death_counts
	
	if experience >= experience_required * level_gap:
		level += 1
		level_gap += 0.5
		experience = 0
		player_damage += 5.0
		
	print(level)
