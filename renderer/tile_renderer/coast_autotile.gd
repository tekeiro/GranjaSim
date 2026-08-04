extends TileRenderer
class_name CoastAutoTile

##
## Algoritmo de AutoTile para cuando tenemos un terreno rodeado de 
## un fluido como el agua
##

var inner_terrain: Enums.TileEnum
var outer_terrain: Enums.TileEnum

# Las posiciones son:
#                          [UL,  U,  UR,  L,  R,  DL,  D,  DR] 
const UL    : Array[int] = [-1,  0,  -1,  0,  1,  -1,  1,  -1 ] # Arriba y Izq es Agua. Derecha y Abajo es Tierra.
const UPPER : Array[int] = [-1,  0,  -1,  1,  1,  -1,  1,  -1 ] # Arriba es Agua. Resto es Tierra.
const UR    : Array[int] = [-1,  0,  -1,  1,  0,  -1,  1,  -1 ] # Arriba y Der es Agua. Izq y Abajo es Tierra.
const LF    : Array[int] = [-1,  1,  -1,  0,  1,  -1,  1,  -1 ] # Izquierda es Agua. Resto es Tierra.
const CT    : Array[int] = [-1,  1,  -1,  1,  1,  -1,  1,  -1 ] # Centro: Todo Tierra. (Puedes poner 1s en diagonales si quieres aislarlo más).
const RT    : Array[int] = [-1,  1,  -1,  1,  0,  -1,  1,  -1 ] # Derecha es Agua.
const DL    : Array[int] = [-1,  1,  -1,  0,  1,  -1,  0,  -1 ] # Abajo e Izq es Agua.
const DW    : Array[int] = [-1,  1,  -1,  1,  1,  -1,  0,  -1 ] # Abajo es Agua.
const DR    : Array[int] = [-1,  1,  -1,  1,  0,  -1,  0,  -1 ] # Abajo y Der es Agua.
#                          [UL,   U,   UR,   L,   R,    DL,    D,   DR] 
# --- 1. BORDES RECTOS ---
const WU : Array[int] = [ 1,  1,  1,   1,  1,  -1,  0,  -1 ] # Tierra Abajo
const WD : Array[int] = [-1,  0, -1,   1,  1,   1,  1,   1 ] # Tierra Arriba
const WL : Array[int] = [ 1,  1, -1,   1,  0,   1,  1,  -1 ] # Tierra a la Derecha
const WR : Array[int] = [-1,  1,  1,   0,  1,  -1,  1,   1 ] # Tierra a la Izquierda
# --- 2. ESQUINAS EXTERNAS (El agua envuelve la tierra) ---
const WUL : Array[int] = [ 1,  1, -1,   1,  0,  -1,  0,  -1 ] # Tierra a la Derecha y Abajo
const WUR : Array[int] = [-1,  1,  1,   0,  1,  -1,  0,  -1 ] # Tierra a la Izquierda y Abajo
const WDL : Array[int] = [-1,  0, -1,   1,  0,   1,  1,  -1 ] # Tierra a la Derecha y Arriba
const WDR : Array[int] = [-1,  0, -1,   0,  1,  -1,  1,   1 ] # Tierra a la Izquierda y Arriba
# --- 3. ESQUINAS INTERNAS / BAHÍAS (La tierra envuelve al agua) ---
# (Tus WULL, WURR, WDLL, WDRR). El agua exige tener agua en los 4 cardinales, 
# y que justo la diagonal sea tierra (0).
const W_IN_UL : Array[int] = [ 0,  1, -1,   1,  1,  -1,  1,  -1 ] # Tierra Arriba-Izq
const W_IN_UR : Array[int] = [-1,  1,  0,   1,  1,  -1,  1,  -1 ] # Tierra Arriba-Der
const W_IN_DL : Array[int] = [-1,  1, -1,   1,  1,   0,  1,  -1 ] # Tierra Abajo-Izq
const W_IN_DR : Array[int] = [-1,  1, -1,   1,  1,  -1,  1,   0 ] # Tierra Abajo-Der


## inner : [UL, U, UR, L, C, R, DL, D, DR]
## 
var inner_tiles: Array[Vector2i] = []

## outer : [REGULAR, UL, L, DLL, DL, D, DR, DRR, R, UR, ULL, URR]
##              0    1   2   3    4  5   6   7   8   9  10    11
var outer_tiles: Array[Vector2i] = []



func _init(the_inner_terrain: Enums.TileEnum, the_outer_terrain: Enums.TileEnum, the_inner_tiles: Array[Vector2i], the_outer_tiles: Array[Vector2i]) -> void:
	self.inner_terrain = the_inner_terrain
	self.outer_terrain = the_outer_terrain
	self.inner_tiles = the_inner_tiles
	self.outer_tiles = the_outer_tiles


func get_sprite(map: Map, r: int, c: int, map_tile: Enums.TileEnum) -> Vector2i:
	if map_tile != inner_terrain and map_tile != outer_terrain:
		return Vector2i.ZERO
	
	if map_tile == inner_terrain:
		if _check_mask_nb(map, r, c, inner_terrain, CT): return inner_tiles[4]
		elif _check_mask_nb(map, r, c, inner_terrain, UPPER): return inner_tiles[1]
		elif _check_mask_nb(map, r, c, inner_terrain, LF): return inner_tiles[3]
		elif _check_mask_nb(map, r, c, inner_terrain, RT): return inner_tiles[5]
		elif _check_mask_nb(map, r, c, inner_terrain, DW): return inner_tiles[7]
		elif _check_mask_nb(map, r, c, inner_terrain, UL): return inner_tiles[0]
		elif _check_mask_nb(map, r, c, inner_terrain, UR): return inner_tiles[2]
		elif _check_mask_nb(map, r, c, inner_terrain, DL): return inner_tiles[6]
		elif _check_mask_nb(map, r, c, inner_terrain, DR): return inner_tiles[8]
		else: return inner_tiles[4]
	elif map_tile == outer_terrain:
		for rule in WATER_RULES.keys():
			if _check_water_rule(map, r, c, outer_terrain, rule):
				return outer_tiles[WATER_RULES[rule]]
		return outer_tiles[0]
	return Vector2i.ZERO

# 10 - WULL
# 11 - WURR
#  5 - WD
#  2 - WL
#  8 - WR
#  4 - WDL
#  6 - WDR
#  0 - WATER REGULAR
const WATER_RULES = {
	"TWTT-TTWT": 2,
	"TTTT-WTWW": 10,
	"TTTW-TWWT": 11,
	"TTTW-WWWW": 5,
	"TWXT-WXXX": 8,
	"TWXT-TXXX": 8,
	"WWTW-TXXX": 2,
	"WWTT-TXXX": 2,
	"WTTW-WXXX": 4,
	"TTWW-WXXX": 6,
	"TWTW-TWWT": 2,
	"TTTW-TWWW": 11,
	"TTTT-WWWW": 10
}

func _check_water_rule(map: Map, r: int, c: int, terrain: Enums.TileEnum, mask: String) -> bool:
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
	if letter == "T": return 0
	elif letter == "W": return 1
	elif letter == "X": return -1
	else: return -2

## 
## mask: [UL, U, UR, L, R, DL, D, DR]
## mask[i] in [0 - != terrain, 1 - same terrain, -1 - dont care]
func _check_mask_nb(map: Map, r: int, c: int, terrain: Enums.TileEnum, mask: Array[int]) -> bool:
	return _check_mask_pos(map, r-1, c-1, terrain, mask[0]) and \
		_check_mask_pos(map, r-1, c, terrain, mask[1]) and \
		_check_mask_pos(map, r-1, c+1, terrain, mask[2]) and \
		_check_mask_pos(map, r, c-1, terrain, mask[3]) and \
		_check_mask_pos(map, r, c+1, terrain, mask[4]) and \
		_check_mask_pos(map, r+1, c-1, terrain, mask[5]) and \
		_check_mask_pos(map, r+1, c, terrain, mask[6]) and \
		_check_mask_pos(map, r+1, c+1, terrain, mask[7])
	
func _check_mask_pos(map: Map, r: int, c: int, terrain: Enums.TileEnum, mask_pos: int) -> bool:
	if mask_pos == 0: return map.get_ground_tile(r, c) != terrain
	elif mask_pos > 0: return map.get_ground_tile(r, c) == terrain
	else: return true
