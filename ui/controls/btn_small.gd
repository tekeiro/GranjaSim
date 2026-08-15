extends TextureButton

@export var icon_texture: Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.icon_texture:
		var icon = get_child(0) as TextureRect
		icon.texture = self.icon_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
