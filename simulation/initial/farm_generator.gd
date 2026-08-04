extends RefCounted
class_name FarmGenerator

func generate_farm(options: MapGenerator.MapGeneratorOptions, seed: int = 0):
	var randr = RandomUtils.make_random_generator(seed)
	
	## Initial money
	Farm.money = Constants.INITIAL_MONEY
	
	## Map generation
	var map_generator = MapGenerator.new()
	var map = map_generator.generate_map(options, seed)
	Farm.map = map
	
	## Initialize land tiles
	Farm.land_tiles.initialize()
	
	# Calculate Start farm position
	var start_farm_positioner = StartFarmPositioner.new()
	start_farm_positioner.generate_start_farm_position(seed)
	
