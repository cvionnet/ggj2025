extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_camera_rect() -> Rect2:
	# Récupérer la position de la caméra
	var camera_position = global_position

	# Obtenir la taille de la vue (viewport) divisée par le zoom de la caméra
	var viewport_size = Vector2(get_viewport().size) / zoom

	# Calculer les limites de la caméra
	return Rect2(
		camera_position - viewport_size / 2,  # Position en haut à gauche
		viewport_size  # Taille visible par la caméra
		)
