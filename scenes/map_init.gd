extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var options = MapGenerator.MapGeneratorOptions.new()
	options.river = true
	
	var map_generator = MapGenerator.new()
	var map = map_generator.generate_map(options)
	Farm.map = map
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
