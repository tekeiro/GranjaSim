extends "res://ui/controls/btn.gd"

@export var tool: Enums.TileEnum = Enums.TileEnum.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	connect("toggled", _on_toggled)
	pass # Replace with function body.


func _on_toggled(toggled_on: bool) -> void:
	Farm.tool_selected = tool
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if Farm.tool_selected == tool:
		set_pressed_no_signal(true)
	else:
		set_pressed_no_signal(false)
	pass
