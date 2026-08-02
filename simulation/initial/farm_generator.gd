extends RefCounted
class_name FarmGenerator

func generate_farm(options: MapGenerator.MapGeneratorOptions, seed: int = 0):
	var randr = RandomUtils.make_random_generator(seed)
	
	## Initial money
	Farm.money = Constants.INITIAL_MONEY
	
	## Map generation
	var map_generator = MapGenerator.new()
	map_generator.generate_map(options, seed)
	var map = Farm.map
	
	## Initialize land tiles
	Farm.land_tiles.initialize()
	
