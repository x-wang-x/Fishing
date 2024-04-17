extends Control

signal result(reward : int)

@onready var timer : Timer = $Timer
@export var initial_speed : float = 2
@export var click_range : Vector2 = Vector2(1,10)
@export var cycle : int = 2
@export var cycle_multiplier: float = 0.8
@export var cycle_timeout : float = 10

enum _runState {
	up,
	down
}
var _currentCycle : int = 0
var _currentSpeed : float
var _currentState : _runState
var running : bool 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	click_range = gen_random()
	click_range = clamp(click_range,Vector2.ZERO,Vector2(100,100))
	$"Click Region".size.y = (click_range.y - click_range.x) / 100 * $NinePatchRect.size.y
	$"Click Region".position.y += click_range.x
	_currentSpeed = initial_speed
	start(_currentSpeed)	
	running = true
	$Timeout.start(cycle_timeout)
	

func _process(delta: float) -> void:
	if running and _currentCycle < cycle : 
		var time_left = int(timer.time_left/_currentSpeed * 100)	
		match _currentState:
			_runState.up:
				time_left = time_left
			_runState.down:
				time_left = 100 - time_left
		run(time_left)
		
		if timer.is_stopped() :
			_currentState = _runState.down if (_currentState == _runState.up) else _runState.up
			start(_currentSpeed)
			
		if Input.is_action_just_pressed("ui_accept"):
			if time_left >= click_range.x and time_left <= click_range.y :
				timer.stop()
				$Timeout.start(cycle_timeout)
				_currentCycle += 1
				_currentSpeed = _currentSpeed * cycle_multiplier			
				start(_currentSpeed)
				$Label.text = "Good"
				
			else:
				$Label.text = "Try Again"

	else :
		var random_rarity = randomize_rarity()
		
		result.emit(random_rarity)
		
			
			
func run(left : int) -> void :
	$VScrollBar.value = left		
	
func start(value : float) -> void:
	timer.start(value)
	
func pause() -> void:
	timer.paused = !timer.paused
	
		
func _on_timer_timeout() -> void:
	pass


func _on_timeout_timeout() -> void:
	result.emit(false)
	
enum Rarity {
	COMMON,
	RARE,
	SUPER_RARE
}

var rarity_weights = {
	Rarity.COMMON: 50,
	Rarity.RARE: 40,
	Rarity.SUPER_RARE: 10
}

func randomize_rarity():
	var rarities = []
	var weights = []

	for key in rarity_weights.keys():
		rarities.append(key)
		weights.append(rarity_weights[key])
	var selected_rarity_index = weighted_random_choice(weights)
	return rarities[selected_rarity_index]

func weighted_random_choice(weights):
	var total_weight = 0
	for weight in weights:
		total_weight += weight

	var rnd = randf() * total_weight
	
	var sum_weight = 0
	for i in range(weights.size()):
		sum_weight += weights[i]
		if rnd < sum_weight:
			return i
			
func gen_random() -> Vector2i:
	
	var x = randi_range(0,100)
	var y = randi_range(x+4,100)
	
	return Vector2i(x,y)
