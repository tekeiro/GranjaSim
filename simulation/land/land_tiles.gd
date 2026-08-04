extends RefCounted
class_name LandTiles

var _land: Array[LandTile] = []
var _rows := 0
var _cols := 0

## Returns number of columns in land tiles
func cols() -> int:
	return _cols
	
## Returns number of rows in land tiles
func rows() -> int:
	return _rows
	
## Get a land tile given a (row, col) coordinate
func get_land(row: int, col: int) -> LandTile:
	return _land[row * cols() + col]
	
## Replace a land tile with the given tile that its in (row, col) coordinate
func set_land(row: int, col: int, land_tile: LandTile):
	_land[row * cols() + col] = land_tile
	
func land_tile_to_map(row: int, col: int) -> Vector2i:
	return Vector2i(row * Constants.LAND_TILE_H, col * Constants.LAND_TILE_W)
	

func initialize(): 
	var map = Farm.map
	_rows = Farm.map.height() / Constants.LAND_TILE_H
	_cols = Farm.map.width() / Constants.LAND_TILE_W
	var land_max_w = _cols
	var land_max_h = _rows
	
	_land = []
	for r in range(land_max_h):
		for c in range(land_max_w):
			var land_tile = LandTile.new()
			land_tile.coords = Vector2i(r, c)
			land_tile.bought = false
			land_tile.price = LandTilePriceEvaluator.evaluate_price(r, c)
			_land.append(land_tile)
