extends Camera2D

@export var speed = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		move_local_y(-speed)
	elif Input.is_action_pressed("ui_down"):
		move_local_y(speed)
	elif Input.is_action_pressed("ui_left"):
		move_local_x(-speed)
	elif Input.is_action_pressed("ui_right"):
		move_local_x(speed)
	pass
