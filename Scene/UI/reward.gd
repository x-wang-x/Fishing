extends Control

@export var rewardName : String
@export var rewardTexture : Texture2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NinePatchRect/Name.text = rewardName
	$NinePatchRect/TextureRect.texture = rewardTexture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
