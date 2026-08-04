extends RefCounted
class_name Enums

enum TileEnum {
	NONE,
	
	TERRAIN, WATER,
	
	FENCE, ROAD, DITCH
}

static func is_terrain(type: TileEnum) -> bool:
	return type == TileEnum.TERRAIN or type == TileEnum.WATER

const TILE_GROUPS = {
	TileEnum.TERRAIN: TileGroup.TERRAIN,
	TileEnum.WATER: TileGroup.TERRAIN,
	TileEnum.FENCE: TileGroup.FENCES,
}

enum TileGroup {
	TERRAIN,
	ROADS,
	FENCES,
	STRUCTURE,
	CROP_FIELD,
}
