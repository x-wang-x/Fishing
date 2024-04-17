extends Node2D
class_name World

@onready var pausemenu : Control = $Camera2D/Pause
@onready var tile_map: TileMap = $TileMap

var paused : bool = false
static var _instance : World = null

func _ready() -> void:
	_instance = self if _instance == null else _instance
	
static func get_tile_at(pos : Vector2,layer : int) -> TileData:
	var local : Vector2i = _instance.tile_map.local_to_map(pos)
	
	return _instance.tile_map.get_cell_tile_data(layer,local)
	
	
static func get_custom_data(pos : Vector2, dataname : String, layer :int) -> Variant:
	var data = get_tile_at(pos,layer)
	if data != null :
		return data.get_custom_data(dataname)
	return null
	
func _input(event : InputEvent):
	if event.is_action_pressed("ui_cancel"):
		pauseMenu()
func pauseMenu():
	if paused:
		pausemenu.hide()
		Engine.time_scale = 1
	else :
		pausemenu.show()
		Engine.time_scale = 0
		
	paused = !paused


func _on_bar_result(res : int) -> void:
	var instance = preload("res://Scene/UI/Reward.tscn").instantiate()
	var reward : String
	match res:
		0: 
			reward = "common"
		1:
			reward = "rare"
		2:
			reward = "super rare"
				
	instance.rewardName = reward
	instance.rewardTexture = load("res://icon.svg")
	get_node("Camera2D").add_child(instance)
	if (get_node("CanvasLayer").has_node("Bar")): 
		get_node("CanvasLayer/Bar").queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var instance = preload("res://GameUI/bar.tscn").instantiate()
	instance.initial_speed = 2
	instance.click_range = Vector2(5,50)
	instance.connect("result",_on_bar_result)
	get_node("CanvasLayer").add_child(instance)

	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (get_node("CanvasLayer").has_node("Bar")): 
		get_node("CanvasLayer/Bar").queue_free()
	
