extends RefCounted
class_name Map


var _width := 0
var _height := 0

##  tiles : Array[Array[MapTile]] [row, col]
var tiles : Array[Array] = []



func initialize(the_width: int, the_height: int):
	self._width = the_width
	self._height = the_height
	tiles = []
	for r in range(_height):
		tiles.append([])
		for c in range(_width):
			tiles[r].append(MapTile.new_terrain(Enums.TileEnum.TERRAIN))

func width() -> int:
	return self._width
func height() -> int:
	return self._height

func get_tile_type(r: int, c: int) -> Enums.TileEnum:
	if r < 0 or r >= self._height:
		return Enums.TileEnum.NONE
	if c < 0 or c >= self._width:
		return Enums.TileEnum.NONE
	return tiles[r][c].get_tile_type()
	
func get_ground_tile(r: int, c: int) -> Enums.TileEnum:
	if r < 0 or r >= self._height:
		return Enums.TileEnum.NONE
	if c < 0 or c >= self._width:
		return Enums.TileEnum.NONE
	return tiles[r][c].get_ground_tile()

func set_ground_tile(r: int, c: int, type: Enums.TileEnum):
	if type != Enums.TileEnum.NONE && Enums.is_terrain(type):
		tiles[r][c] = MapTile.new_terrain(type)
		
func get_tile(r: int, c: int) -> Enums.TileEnum:
	if r < 0 or r >= self._height:
		return Enums.TileEnum.NONE
	if c < 0 or c >= self._width:
		return Enums.TileEnum.NONE
	return tiles[r][c].get_tile_type()
	
func get_surface_tile(r: int, c: int) -> Enums.TileEnum:
	if r < 0 or r >= self._height:
		return Enums.TileEnum.NONE
	if c < 0 or c >= self._width:
		return Enums.TileEnum.NONE
	return tiles[r][c].get_surface_tile()
	
func set_surface_tile(r: int, c:int, tile: Enums.TileEnum):
	if tile != Enums.TileEnum.NONE and not Enums.is_terrain(tile):
		var prev_tile = tiles[r][c]
		prev_tile.surface = tile
		prev_tile.group = Enums.TILE_GROUPS[tile]
