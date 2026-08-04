extends RefCounted
class_name Tiles

# TERRAIN
const TERRAIN_CENTER = Vector2i(16, 26)
const TERRAIN_LEFT = Vector2i(15, 26)
const TERRAIN_RIGHT = Vector2i(17, 26)
const TERRAIN_UP = Vector2i(16, 25)
const TERRAIN_DOWN = Vector2i(16, 27)
const TERRAIN_UP_LEFT = Vector2i(15, 25)
const TERRAIN_UP_RIGHT = Vector2i(17, 25)
const TERRAIN_DOWN_LEFT = Vector2i(15, 27)
const TERRAIN_DOWN_RIGHT = Vector2i(17, 27)

# WATER
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
	
	
# FENCE
const FENCE_UL = Vector2i(22, 21)
const FENCE_UR = Vector2i(21, 21)
const FENCE_DL = Vector2i(22, 20)
const FENCE_DR = Vector2i(21, 20)
const FENCE_D = Vector2i(20, 19)
const FENCE_UD = Vector2i(20, 20)
const FENCE_U = Vector2i(20, 21)
const FENCE_R = Vector2i(21, 19)
const FENCE_LR = Vector2i(22, 19)
const FENCE_L = Vector2i(23, 19)
const FENCE_4 = Vector2i(23, 20)
const FENCE_LRD = Vector2i(23, 21)
const FENCE_LRU = Vector2i(24, 21)
const FENCE_URD = Vector2i(26, 21)
const FENCE_ULD = Vector2i(27, 21)
const FENCE_SINGLE = Vector2i(25, 21)

## All tiles mapping
## [S, U, L, R, D, UL, UR, DL, DR, UD, LR, LRU, LRD, ULD, URD, 4D]
##  0  1  2  3  4  5   6   7   8   9   10  11   12   13   14   15
static var _fence_autotile = AutoTile8D.new(Enums.TileEnum.FENCE, [
	FENCE_SINGLE, FENCE_U, FENCE_L, FENCE_R, FENCE_D,
	FENCE_UL, FENCE_UR, FENCE_DL, FENCE_DR, FENCE_UD, FENCE_LR,
	FENCE_LRU, FENCE_LRD, FENCE_ULD, FENCE_URD, FENCE_4
])

static func render_tile(tile: Enums.TileEnum) -> TileRenderer:
	return {
		Enums.TileEnum.TERRAIN: _water_terrain,
		Enums.TileEnum.WATER: _water_terrain,
		Enums.TileEnum.FENCE: _fence_autotile
	}[tile]
