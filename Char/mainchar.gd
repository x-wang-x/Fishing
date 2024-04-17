extends CharacterBody2D


const SPEED = 100.0

func _physics_process(delta):
	if velocity.normalized() == Vector2.ZERO:
		$AnimatedSprite2D.stop()
	if velocity.normalized() == Vector2.DOWN:
		$AnimatedSprite2D.play("front")
	if velocity.normalized() == Vector2.UP:
		$AnimatedSprite2D.play("back")
	if velocity.normalized() == Vector2.RIGHT:
		$AnimatedSprite2D.play("right")
	if velocity.normalized() == Vector2.LEFT:
		$AnimatedSprite2D.play("left")		
	 	
func _process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_npc_body_entered(body):
	print(body)


func _on_npc_body_exited(body):
	print("exit")


