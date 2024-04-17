extends NinePatchRect

@onready var StartBrn = $VBoxContainer/StartButton

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
