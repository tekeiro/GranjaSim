extends RefCounted
class_name StartFarmPositioner

func generate_start_farm_position(seed: int = 0):
	var randr = RandomUtils.make_random_generator(seed)
	var land_tiles = Farm.land_tiles
	var map = Farm.map
	
	# Search for a random position to start the farm
	var tile_start_farm_c = randr.randi_range(0, land_tiles.cols()-Constants.INITIAL_LAND_TILES_BUY_W)
	var tile_start_farm_r = randr.randi_range(0, land_tiles.rows()-Constants.INITIAL_LAND_TILES_BUY_H)
	Farm.start_pos = land_tiles.land_tile_to_map(tile_start_farm_r, tile_start_farm_c)
	# Mark land tiles as bought
	for r in range(Constants.INITIAL_LAND_TILES_BUY_H):
		for c in range(Constants.INITIAL_LAND_TILES_BUY_W):
			var land_tile = land_tiles.get_land(tile_start_farm_r+r, tile_start_farm_c+c)
			land_tile.bought = true
			land_tiles.set_land(tile_start_farm_r+r, tile_start_farm_c+c, land_tile)
	
	# TODO Initial layout of the farm
	var max_r = Constants.INITIAL_LAND_TILES_BUY_H * Constants.LAND_TILE_H
	var max_c = Constants.INITIAL_LAND_TILES_BUY_W * Constants.LAND_TILE_W
	var start_r = Farm.start_pos.x
	var start_c = Farm.start_pos.y
	for c in range(max_c):
		map.set_surface_tile(start_r, start_c+c, Enums.TileEnum.FENCE)
		map.set_surface_tile(start_r+max_r-1, start_c+c, Enums.TileEnum.FENCE)
	for r in range(max_r):
		map.set_surface_tile(start_r+r, start_c, Enums.TileEnum.FENCE)
		map.set_surface_tile(start_r+r, start_c+max_c-1, Enums.TileEnum.FENCE)
	
	
	pass
