extends RefCounted
class_name Tiles

const TERRAIN_CENTER = Vector2i(16, 26)
const TERRAIN_LEFT = Vector2i(15, 26)
const TERRAIN_RIGHT = Vector2i(17, 26)
const TERRAIN_UP = Vector2i(16, 25)
const TERRAIN_DOWN = Vector2i(16, 27)
const TERRAIN_UP_LEFT = Vector2i(15, 25)
const TERRAIN_UP_RIGHT = Vector2i(17, 25)
const TERRAIN_DOWN_LEFT = Vector2i(15, 27)
const TERRAIN_DOWN_RIGHT = Vector2i(17, 27)

const WATER = Vector2i(6, 14)
const WATER_LEFT = Vector2i(14, 26)
const WATER_UP_LEFT = Vector2i(14, 25)
const WATER_DOWN_LL = Vector2i(14, 28)
const WATER_DOWN_LEFT = Vector2i(15, 28)
const WATER_DOWN = Vector2i(16, 28)
const WATER_RIGHT = Vector2i(18, 26)
const WATER_UP_RIGHT = Vector2i(18, 25)
const WATER_DOWN_RR = Vector2i(18, 28)
const WATER_DOWN_RIGHT = Vector2i(17, 28)
const WATER_UP_LL = Vector2i(27, 24)
const WATER_UP_RR = Vector2i(28, 24)


## inner : [UL, U, UR, L, C, R, DL, D, DR]
## outer : [REGULAR, UL, L, DLL, DL, D, DR, DRR, R, UR]

static var _water_terrain := CoastAutoTile.new(Enums.TileEnum.TERRAIN, Enums.TileEnum.WATER, 
	[TERRAIN_UP_LEFT, TERRAIN_UP, TERRAIN_UP_RIGHT, 
	 TERRAIN_LEFT, TERRAIN_CENTER, TERRAIN_RIGHT,
	 TERRAIN_DOWN_LEFT, TERRAIN_DOWN, TERRAIN_DOWN_RIGHT], 
	[WATER, WATER_UP_LEFT, WATER_LEFT, WATER_DOWN_LL, WATER_DOWN_LEFT,
	WATER_DOWN, WATER_DOWN_RIGHT, WATER_DOWN_RR, WATER_RIGHT, WATER_UP_RIGHT,
	WATER_UP_LL, WATER_UP_RR])
static func water_terrain_autotile() -> CoastAutoTile:
	return _water_terrain
