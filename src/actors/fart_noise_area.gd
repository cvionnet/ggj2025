extends Area2D

# Variable pour activer ou désactiver la détection
var detection_active: bool = false

# Liste des ennemis dans la zone
var detected_enemies: Array = []

# Fonction appelée quand un corps entre dans la zone
func _on_Area2D_body_entered(body):
	if detection_active and body.is_in_group("enemies"):
		if body not in detected_enemies:
			detected_enemies.append(body)
			print("Ennemi détecté :", body.name)
			# Ajoute ici la logique de détection de l'ennemi (exemple : activer une alerte)

# Fonction appelée quand un corps sort de la zone
func _on_Area2D_body_exited(body):
	if body in detected_enemies:
		detected_enemies.erase(body)
		print("Ennemi sorti de la zone :", body.name)
		# Ajoute ici la logique de "perte" de détection

# Activer/désactiver la détection
func set_detection_active(active: bool):
	detection_active = active
	$CollisionShape2D.disabled= !active
	monitoring = active  # Active/désactive la surveillance de l'Area2D
