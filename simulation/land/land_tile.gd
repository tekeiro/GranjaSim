extends RefCounted
class_name LandTile

## coords of this land tile in (row, col) format
var coords: Vector2i = Vector2i(0, 0)

var price: float = 0.0

var bought: bool = false


func get_tile_x() -> int:
	return coords[1] * Constants.LAND_TILE_W
func get_tile_y() -> int:
	return coords[0] * Constants.LAND_TILE_H
func get_tile_x_end() -> int:
	return coords[1] * Constants.LAND_TILE_W + (Constants.LAND_TILE_W - 1)
func get_tile_y_end() -> int:
	return coords[0] * Constants.LAND_TILE_H + (Constants.LAND_TILE_H - 1)
