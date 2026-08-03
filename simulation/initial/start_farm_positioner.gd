extends RefCounted
class_name StartFarmPositioner

func generate_start_farm_position(seed: int = 0):
	var randr = RandomUtils.make_random_generator(seed)
	var land_tiles = Farm.land_tiles
	var map = Farm.map
	
	# Search for a random position to start the farm
	var tile_start_farm_c = randr.randi_range(0, land_tiles.cols()-Constants.INITIAL_LAND_TILES_BUY_W-1)
	var tile_start_farm_r = randr.randi_range(0, land_tiles.rows()-Constants.INITIAL_LAND_TILES_BUY_H-1)
	Farm.start_pos = land_tiles.land_tile_to_map(tile_start_farm_r, tile_start_farm_c)
	# Mark land tiles as bought
	for r in range(Constants.INITIAL_LAND_TILES_BUY_H):
		for c in range(Constants.INITIAL_LAND_TILES_BUY_W):
			var land_tile = land_tiles.get_land(tile_start_farm_r+r, tile_start_farm_c+c)
			land_tile.bought = true
			land_tiles.set_land(tile_start_farm_r+r, tile_start_farm_c+c, land_tile)
	
	# TODO Initial layout of the farm
	Constants.INITIAL_LAND_TILES_BUY_H * Constants.LAND_TILE_H
	
	pass
