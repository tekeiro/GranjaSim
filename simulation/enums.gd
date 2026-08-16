extends RefCounted
class_name Enums

enum TileEnum {
	NONE, 
	HAND, LENS, BULLDOZER,
	
	TERRAIN, WATER,
	
	FENCE, PATH, ROAD, GATE_FENCE,
	PLANT,
	FEEDER, DRINKING,
	
	SMALL_SILO, BIG_SILO, 
	SMALL_SHED, BIG_SHED,
	SMALL_BARN, BIG_BARN,
	
	WATER_TOWER, WATER_PUMP, WINDMILL,
	DITCH, DITCH_INTERRUPTOR,
	
	S_FERTILIZER, S_PESTICIDE, S_FUNGICIDE, S_HERBICIDE,
	
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
