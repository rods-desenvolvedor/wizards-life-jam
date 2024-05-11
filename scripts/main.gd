extends Node


@onready var shop_timer : Timer = $ShopTimer
@onready var player : CharacterBody2D = $Player

var status_open : bool = false

var day : int = 1

func _ready():
	player = get_tree().get_first_node_in_group("player")


func _process(delta):
	
	if Input.is_action_just_pressed("status"):
		status_open = true
		
	if status_open:
		get_tree().paused = true
		$PlayerStatus.show() 

func _on_simple_npc_player_on_npc_area():
	$SimpleShop.visible = true


func _on_simple_npc_player_off_npc_area():
	print("jogador saiu da area")


func _on_shop_timer_timeout():
	day += 1
	shop_timer.start()


func _on_close_status_button_pressed():
	print("despausar")
	status_open = false
	get_tree().paused = false
	$PlayerStatus.hide()
	
