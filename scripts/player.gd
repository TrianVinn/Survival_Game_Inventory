extends CharacterBody2D

@export var speed = 200

var target = position

				### При клике, игрок двигаеться ###
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
	if event is InputEventMouseMotion:
		$Camera2D.global_position += event.relative * 0.01
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Camera2D.zoom -= Vector2(0.1,0.1)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Camera2D.zoom += Vector2(0.1,0.1)
			
func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	
