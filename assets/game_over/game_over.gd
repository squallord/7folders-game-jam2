extends CanvasLayer


func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_btn_pressed():
	get_tree().quit()
