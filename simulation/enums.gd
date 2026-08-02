extends RefCounted
class_name Enums

enum TileEnum {
	NONE,
	
	TERRAIN, WATER,
	
	FENCE, ROAD, DITCH
}

static func is_terrain(type: TileEnum) -> bool:
	return type == TileEnum.TERRAIN or type == TileEnum.WATER

enum TileGroup {
	TERRAIN,
	ROADS,
	STRUCTURE,
	CROP_FIELD,
}
