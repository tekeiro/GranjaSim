extends RefCounted
class_name MapTile

var ground := Enums.TileEnum.TERRAIN
var surface := Enums.TileEnum.NONE
var group := Enums.TileGroup.TERRAIN

func get_tile_type() -> Enums.TileEnum:
	return surface if surface != Enums.TileEnum.NONE else ground
	
func get_ground_tile() -> Enums.TileEnum:
	return ground

### --------------- Generators ---------------------
static func new_terrain(type: Enums.TileEnum) -> MapTile:
	var tile = MapTile.new()
	tile.ground = type
	tile.group = Enums.TileGroup.TERRAIN
	return tile
### --------------- Generators ---------------------
