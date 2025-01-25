extends Node2D

enum EnemyType {
	GRANNY,
	MUSCLE,
	LIFEGUARD,
	BOY
}

var enemy_scene = preload("res://src/enemies/Enemy.tscn")  # Remplace par le chemin de ta scène d'ennemi
var spawn_area = Rect2(Vector2(100, 100), Vector2(1000, 600))  # Zone où tu veux générer les ennemis
var spawn_interval = 5.0  # Intervalle entre chaque génération d'ennemi en secondes
var timer: Timer

@onready var camera = get_node("Camera2D") 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Créer un timer pour générer les ennemis
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false  # Permet de répéter l'action
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)  # Ajouter le timer à la scène
	timer.start()  # Démarrer le timer

# Fonction appelée à chaque expiration du timer
func _on_timer_timeout():
	spawn_enemy(random_enemy_type())

func random_enemy_type() -> int:
	# Liste des types d'ennemis sans LIFEGUARD
	var allowed_enemy_types = [EnemyType.GRANNY, EnemyType.MUSCLE, EnemyType.BOY]
	# Tirer un type aléatoire dans la liste
	return allowed_enemy_types[randi() % allowed_enemy_types.size()]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Fonction pour générer un ennemi à une position aléatoire
func spawn_enemy(type : int):
	var enemy_instance = enemy_scene.instantiate() # Instancier la scène de l'ennemi
	enemy_instance.enemy_type = type
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		)  # Générer une position aléatoire dans la zone spécifiée
	enemy_instance.position = random_position  # Placer l'ennemi à la position générée
	add_child(enemy_instance)  # Ajouter l'ennemi à la scène


#Fonction pour obtenir une position aléatoire en dehors de la vue de la caméra
func get_random_position_outside_camera_view() -> Vector2:
	var camera_rect = camera.get_camera_rect()  # La zone visible par la caméra (en pixels)
	var random_position = Vector2()
	# Choisir une position en dehors de la caméra (en haut, en bas, à gauche, à droite)
	match randi() % 4:
		# En haut
		0:
			random_position.x = randf_range(0, get_viewport().size.x)
			random_position.y = randf_range(0, camera_rect.position.y)  # Au-dessus de la caméra
			# En bas
		1:
			random_position.x = randf_range(0, get_viewport().size.x)
			random_position.y = randf_range(camera_rect.position.y + camera_rect.size.y, get_viewport().size.y)  # En-dessous de la caméra
			 # À gauche
		2:
			random_position.x = randf_range(0, camera_rect.position.x)  # À gauche de la caméra
			random_position.y = randf_range(0, get_viewport().size.y)
		# À droite
		3:
			random_position.x = randf_range(camera_rect.position.x + camera_rect.size.x, get_viewport().size.x)  # À droite de la caméra
			random_position.y = randf_range(0, get_viewport().size.y)
	return random_position
