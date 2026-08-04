extends TileMapLayer


var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_node("../Camera")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not camera:
		return
		
	# 1. Obtener el tamaño visible (teniendo en cuenta si la cámara tiene zoom)
	var viewport_size = get_viewport_rect().size / camera.zoom
	
	# 2. Calcular las esquinas en coordenadas del mundo
	var cam_pos = camera.global_position
	var top_left = cam_pos - (viewport_size / 2.0)
	var bottom_right = cam_pos + (viewport_size / 2.0)
	
	# 3. Convertir las coordenadas del mundo a coordenadas de tu mapa (grid)
	# to_local convierte a coordenadas relativas al TileMapLayer
	var start_tile = local_to_map(to_local(top_left))
	var end_tile = local_to_map(to_local(bottom_right))
	
	# 4. Añadir un margen (buffer) para que la carga no se vea en pantalla
	var margin = 2
	
	# clamp (o mini/maxi) evita que intentemos leer fuera de los límites de GameState.map
	var min_x = maxi(0, start_tile.x - margin)
	var min_y = maxi(0, start_tile.y - margin)
	var max_x = mini(Farm.map.width(), end_tile.x + margin + 1)
	var max_y = mini(Farm.map.height(), end_tile.y + margin + 1)
	
	# 5. Iterar solo sobre la porción visible de la matriz
	for row in range(min_y, max_y):
		for col in range(min_x, max_x):
			var terrain = Farm.map.get_ground_tile(row, col)
			var tile = Tiles.WATER if terrain == Enums.TileEnum.WATER else Tiles.TERRAIN_CENTER
			set_cell(Vector2i(col, row), 0, tile)

	pass
