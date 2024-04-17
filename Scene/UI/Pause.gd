extends NinePatchRect



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/UI/MainUI.tscn")


func _on_resume_pressed():
	print(get_parent().get_parent().get_parent().pauseMenu())
