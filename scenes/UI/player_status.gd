extends CanvasLayer

signal close_status


func _on_close_status_button_pressed():
	close_status.emit()
