extends RefCounted
class_name MapGenerator

const MAP_WIDTH := 32
const MAP_HEIGHT := 32
const MAX_RIVER_WIDTH := 6
const RIVER_OFFSET := 1
const RIVER_CONTINOUS_OFFSET := 4


const TERRAIN = Enums.TileEnum.TERRAIN
const WATER = Enums.TileEnum.WATER

## Options for map generation
## river: Boolean. Generate a river or not.
class MapGeneratorOptions:
	var river: bool = false
	

# Map Generation
#   * River generation
#   * Where farm will start
func generate_map(options: MapGeneratorOptions, seed: int = 0) -> Map:
	var randr = RandomUtils.make_random_generator(seed)
	
	var map = Map.new()
	map.initialize(MAP_WIDTH, MAP_HEIGHT)
	self._river_generation(randr, map)
	
	var debug_pattern = [
		[WATER, WATER, WATER, WATER, WATER, WATER, WATER, WATER],
		[WATER, WATER, WATER, WATER, WATER, WATER, WATER, WATER],
		[WATER, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, WATER],
		[WATER, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, WATER],
		[WATER, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, TERRAIN, WATER],
		[WATER, WATER, WATER, WATER, WATER, WATER, WATER, WATER],
		[WATER, WATER, WATER, WATER, WATER, WATER, WATER, WATER],
	]
	self._pattern_to_draw(randr, map, debug_pattern)
	
	return map
	
func _pattern_to_draw(randr: RandomNumberGenerator, map: Map, pattern: Array):
	if pattern.is_empty():
		return
		
	var rows = pattern.size()
	var cols = pattern[0].size()
	
	var row_orig = randr.randi_range(0, MAP_HEIGHT - rows)
	var col_orig = randr.randi_range(0, MAP_WIDTH - cols)
	for r in range(rows):
		for c in range(cols):
			var tile_to_draw = pattern[r][c]
			map.set_ground_tile(row_orig + r, col_orig + c, tile_to_draw)


func _river_generation(randr: RandomNumberGenerator, map: Map):
	# River generation options
	var is_vertical := randr.randi_range(0, 1) == 1
	var max_river_width := randr.randi_range(1, MAX_RIVER_WIDTH) * 2
	
	if is_vertical:
		# Índices de 0 a WIDTH-1 (asumiendo que tus matrices empiezan en 0)
		var current_center = randr.randi_range(0, MAP_WIDTH - 1)
		var current_width = randr.randi_range(2, max_river_width)
		var continuous_offset = randr.randi_range(1, RIVER_CONTINOUS_OFFSET)
		
		for r in range(MAP_HEIGHT):
			# Variación gradual del ancho
			if continuous_offset == 0:
				current_width += randr.randi_range(-1, 1)
				current_width = clampi(current_width, 2, max_river_width)
			
			var start_c = current_center - (current_width / 2)
			var end_c = current_center + (current_width / 2)
			
			# Asegurar que no dibujamos fuera del mapa
			start_c = clampi(start_c, 0, MAP_WIDTH - 1)
			end_c = clampi(end_c, 0, MAP_WIDTH - 1)
			
			# Bucle optimizado: solo recorre los tiles que realmente son agua
			for c in range(start_c, end_c + 1):
				map.set_ground_tile(r, c, WATER)
				
			# Mover el centro para la siguiente fila
			if continuous_offset == 0:
				current_center += randr.randi_range(-RIVER_OFFSET, RIVER_OFFSET)
				continuous_offset = randr.randi_range(1, RIVER_CONTINOUS_OFFSET)
			else:
				continuous_offset = continuous_offset -1
			
			
	else:
		# Lógica corregida para horizontal (usando filas en lugar de columnas)
		var current_center = randr.randi_range(0, MAP_HEIGHT - 1)
		var current_width = randr.randi_range(2, max_river_width)
		var continuous_offset = randr.randi_range(1, RIVER_CONTINOUS_OFFSET)
		
		for c in range(MAP_WIDTH):
			if continuous_offset == 0:
				current_width += randr.randi_range(-1, 1)
				current_width = clampi(current_width, 2, max_river_width)
			
			var start_r = current_center - (current_width / 2)
			var end_r = current_center + (current_width / 2)
			
			start_r = clampi(start_r, 0, MAP_HEIGHT - 1)
			end_r = clampi(end_r, 0, MAP_HEIGHT - 1)
			
			for r in range(start_r, end_r + 1):
				map.set_ground_tile(r, c, Enums.TileEnum.WATER)
				
			# Mover el centro para la siguiente fila
			if continuous_offset == 0:
				current_center += randr.randi_range(-RIVER_OFFSET, RIVER_OFFSET)
				continuous_offset = randr.randi_range(1, RIVER_CONTINOUS_OFFSET)
			else:
				continuous_offset = continuous_offset -1
