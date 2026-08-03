extends Node2D


@export var seed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var options = MapGenerator.MapGeneratorOptions.new()
	options.river = true
	
	var farm_generator = FarmGenerator.new()
	farm_generator.generate_farm(options, seed)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
