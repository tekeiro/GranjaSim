extends Node
class_name Calendar

enum TimeSpeed {
	PAUSED, SPEED_1, SPEED_2
}

## years(*), months(4), weeks (7), days
const STARTING_YEAR := 1960
const TICKS_PER_DAY := {
	TimeSpeed.PAUSED: 0,
	TimeSpeed.SPEED_1: 2000,
	TimeSpeed.SPEED_2: 1000,
}
const DAYS_PER_WEEK := 7
const WEEKS_PER_MONTH := 4
const MONTHS_PER_YEAR := 12


var _speed: TimeSpeed = TimeSpeed.PAUSED
var _previous_speed := TimeSpeed.SPEED_1
var _ticks := 0.0
var _days := 0
var _weeks := 0
var _months := 0
var _years := STARTING_YEAR


func get_speed() -> TimeSpeed:
	return _speed
func set_speed(new_speed: TimeSpeed):
	_speed = new_speed
func pause() -> void:
	_previous_speed = _speed
	_speed = TimeSpeed.PAUSED
func resume() -> void:
	_speed = _previous_speed
	

func ticks() -> float:
	return _ticks
func days() -> int:
	return _days
func weeks() -> int:
	return _weeks
func months() -> int:
	return _months
func years() -> int:
	return _years

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _speed == TimeSpeed.PAUSED:
		return
	
	_ticks += delta
	var ticks_per_day = TICKS_PER_DAY[_speed]
	if _ticks >= ticks_per_day:
		_ticks -= ticks_per_day
		_days += 1
	if _days >= DAYS_PER_WEEK:
		_days -= DAYS_PER_WEEK
		_weeks += 1
	if _weeks >= WEEKS_PER_MONTH:
		_weeks -= WEEKS_PER_MONTH
		_months += 1
	if _months >= MONTHS_PER_YEAR:
		_months -= MONTHS_PER_YEAR
		_years += 1
	
	
	pass
