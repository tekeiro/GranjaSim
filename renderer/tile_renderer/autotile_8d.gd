extends TileRenderer
class_name AutoTile8D

## What its the tile type
var _tile_type: Enums.TileEnum

## All tiles mapping
## [S, U, L, R, D, UL, UR, DL, DR, UD, LR, LRU, LRD, ULD, URD, 4D]
##  0  1  2  3  4  5   6   7   8   9   10  11   12   13   14   15
var _tiles: Array[Vector2i] = []


func _init(the_tile: Enums.TileEnum, tiles_array: Array[Vector2i]) -> void:
	self._tile_type = the_tile
	self._tiles = tiles_array
	
func tile() -> Enums.TileEnum:
	return self._tile_type
	
	
func get_sprite(map: Map, row: int, col: int, map_tile: Enums.TileEnum) -> Vector2i:
	if map_tile != self._tile_type:
		print_debug("No tile type matched")
		return Vector2i(0, 0)
	
	for rule in RULES.keys():
		if _check_rule(map, row, col, _tile_type, rule):
			return _tiles[RULES[rule]]
	print_debug("otherwise return")
	return _tiles[0]


# UL U UR | L - R | DL D DR
const RULES = {
	"-X-X-X-X-": 0,  # (single)
	"-V-X-X-X-": 1,  # U
	"-X-V-X-X-": 2,  # L
	"-X-X-V-X-": 3,  # R
	"-X-X-X-V-": 4,  # D
	"-V-V-X-X-": 5,  # UL
	"-V-X-V-X-": 6,  # UR
	"-X-V-X-V-": 7,  # DL
	"-X-X-V-V-": 8,  # DR 
	"-V-X-X-V-": 9,  # UD
	"-X-V-V-X-": 10, # LR
	"-V-V-V-X-": 11, # LRU
	"-X-V-V-V-": 12, # LRD
	"-V-V-X-V-": 13, # ULD
	"-V-X-V-V-": 14, # URD
	"-V-V-V-V-": 15, # 4D
}


func _check_rule(map: Map, r: int, c: int, terrain: Enums.TileEnum, mask: String) -> bool:
	return _check_mask_pos(map, r-1, c-1, terrain, _mask(mask, 0)) and \
		_check_mask_pos(map, r-1, c, terrain, _mask(mask, 1)) and \
		_check_mask_pos(map, r-1, c+1, terrain, _mask(mask, 2)) and \
		_check_mask_pos(map, r, c-1, terrain, _mask(mask, 3)) and \
		_check_mask_pos(map, r, c+1, terrain, _mask(mask, 5)) and \
		_check_mask_pos(map, r+1, c-1, terrain, _mask(mask, 6)) and \
		_check_mask_pos(map, r+1, c, terrain, _mask(mask, 7)) and \
		_check_mask_pos(map, r+1, c+1, terrain, _mask(mask, 8))
	
func _mask(mask: String, idx: int) -> int:
	var letter = mask[idx]
	# print_debug("letter: ", letter)
	if letter   == "X": return 0
	elif letter == "V": return 1
	else: return -1

func _check_mask_pos(map: Map, r: int, c: int, terrain: Enums.TileEnum, mask_pos: int) -> bool:
	var curr_tile = map.get_surface_tile(r, c)
	var result = true
	if mask_pos == 0: result =  curr_tile != terrain
	elif mask_pos > 0: result = curr_tile == terrain
	return result
