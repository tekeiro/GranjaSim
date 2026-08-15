extends "res://ui/controls/btn_small.gd"


@export var time_speed: TimeCalendar.TimeSpeed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	TimeCalendar.time_speed_change.connect(_on_time_speed_changed)
	toggled.connect(_on_btn_toggled)
	pass 


func _on_time_speed_changed(new_time_speed: TimeCalendar.TimeSpeed):
	if time_speed == new_time_speed:
		set_pressed_no_signal(true)
	else:
		set_pressed_no_signal(false)


func _on_btn_toggled(toggled_on: bool):
	print_debug("btn_small_time on toggled")
	if toggled_on:
		if time_speed == TimeCalendar.TimeSpeed.PAUSED:
			TimeCalendar.pause()
		else:
			TimeCalendar.set_speed(time_speed)
	else:
		if time_speed == TimeCalendar.TimeSpeed.PAUSED:
			TimeCalendar.resume()
		else:
			TimeCalendar.set_speed(time_speed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	pass
