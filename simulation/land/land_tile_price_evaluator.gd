extends RefCounted
class_name LandTilePriceEvaluator

const LAND_TILE_PRICE := 12500

static func evaluate_price(row: int, col: int) -> float:
	# TODO Replace with a current algorithm that looks for map
	return LAND_TILE_PRICE
