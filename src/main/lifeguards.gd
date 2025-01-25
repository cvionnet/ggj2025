extends Node

@export var move_speed := 200.0  # Vitesse de déplacement
@export var left_bound := 200.0  # Bord gauche (position X minimale)
@export var right_bound := 1400.0  # Bord droit (position X maximale)

func _ready() -> void:
	# Initialisation des directions pour chaque enfant Lifeguard
	for child in get_children():
		child.direction = 1  # Initialise la direction (vers la droite)

func _process(delta: float) -> void:
	# Boucle pour gérer le mouvement de chaque enfant
	for child in get_children():
		if child is Node2D:
			move_and_rotate_lifeguard(child, delta)

func move_and_rotate_lifeguard(lifeguard, delta: float) -> void:
	# Déplace le lifeguard
	lifeguard.position.x += lifeguard.direction * move_speed * delta
	
	# Si le lifeguard atteint le bord gauche
	if lifeguard.position.x <= left_bound:
		lifeguard.direction = 1  # Change de direction (vers la droite)
		lifeguard.rotation_degrees += 180  # Rotation de 90 degrés
	
	# Si le lifeguard atteint le bord droit
	elif lifeguard.position.x >= right_bound:
		lifeguard.direction = -1  # Change de direction (vers la gauche)
		lifeguard.rotation_degrees += 180  # Rotation de 90 degrés
