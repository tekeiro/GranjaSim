extends "res://ui/controls/btn.gd"

@onready var accordion: HBoxContainer = get_node("../HBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	connect("toggled", _on_toggled)
	accordion.visible = false
	pass # Replace with function body.

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		accordion.visible = true
	else:
		accordion.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	pass
