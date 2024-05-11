extends Control

@onready var item : AnimatedSprite2D = $Icon

var item_label : int = 1
const COUNT_ITEMS : int = 2


var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	visible = false
	item.play("health_potion")
	item_label = 1
	
func _process(delta):
	
	if item_label > COUNT_ITEMS:
		item_label = 1
	if item_label < 1:
		item_label = COUNT_ITEMS
	
	if item_label == 1:
		item.play("health_potion")
	elif item_label == 2:
		item.play("mana_potion")

func _on_right_button_pressed():
	item_label += 1


func _on_left_button_pressed():
	item_label -= 1


func _on_close_button_pressed():
	visible = false


func _on_buy_button_pressed():
	buy_item()

	
	
func buy_item():
	var number_tag : int = item_label
	
	if number_tag == 1 && has_money(number_tag):
		player.money -= 100.0
		player.inventory["mana_potion"] += 1
	else:
		print("dinheiro insuficiente")
		
	
func has_money(item_tag : int) -> bool:
	
	if item_label == 1:
		if player.money < 25.0:
			return false
	
	return true
	
	
