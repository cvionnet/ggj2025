extends Node2D

enum EnemyType {
	GRANNY,
	MUSCLE,
	LIFEGUARD,
	BOY
}

@export var GameOverScreen: String = "res://src/menu/GameOver.tscn"

var enemy_scene = preload("res://src/enemies/Enemy.tscn") # Remplace par le chemin de ta scène d'ennemi
var spawn_area = Rect2(Vector2(100, 100), Vector2(1000, 600)) # Zone où tu veux générer les ennemis
var spawn_interval = 5.0 # Intervalle entre chaque génération d'ennemi en secondes
var timer: Timer

@onready var water_area = $Background/Water
@onready var player = get_node("Player")
@onready var camera = player.get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#gestion du gameOver
	var Suspiciousbar = get_node('/root').find_child("Suspiciousbar", true, false)
	Suspiciousbar.connect("GameOver", Callable(self, "_GameOver_detected"))
	# Créer un timer pour générer les ennemis
	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.one_shot = false # Permet de répéter l'action
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer) # Ajouter le timer à la scène
	timer.start() # Démarrer le timer

func _process(_delta):
	pass


#*--------------------------------------------------------------------------*//
#*--    CALLBACK SIGNAL    ----------------------------------------------------*//
func _GameOver_detected()->void:
	StartEndGame()



#*--------------------------------------------------------------------------*//
#*--    USER METHODS    ----------------------------------------------------*//

# Fonction appelée à chaque expiration du timer
func _on_timer_timeout():
	spawn_enemy(random_enemy_type())

func random_enemy_type() -> int:
	# Liste des types d'ennemis sans LIFEGUARD
	var allowed_enemy_types = [EnemyType.GRANNY, EnemyType.MUSCLE, EnemyType.BOY]
	# Tirer un type aléatoire dans la liste
	return allowed_enemy_types[randi() % allowed_enemy_types.size()]

# Fonction pour générer un ennemi à une position aléatoire
func spawn_enemy(type: int):
	if not water_area:
		print("Erreur : La zone 'Water' n'existe pas.")
		return
	
	var enemy_instance = enemy_scene.instantiate() # Instancier la scène de l'ennemi
	enemy_instance.enemy_type = type
	
	# var spawn_position = get_random_position_in_water_outside_camera_view()
	
	var random_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x),
		randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
		) # Générer une position aléatoire dans la zone spécifiée
	enemy_instance.position = random_position # Placer l'ennemi à la position générée
	add_child(enemy_instance) # Ajouter l'ennemi à la scène

# Fonction pour obtenir une position aléatoire dans "Water"
func get_random_position_in_water(_margin: float = 100.0) -> Vector2:
	var texture_size = water_area.texture.get_size() # Taille de la texture
	# var scale = water_area.scale # Échelle appliquée au sprite
	# var global_position = water_area.global_position # Position globale du sprite
	
	# Calculer les dimensions réelles avec l'échelle
	var width = texture_size.x * scale.x
	var height = texture_size.y * scale.y
	
	# Obtenir une position aléatoire dans les limites du sprite
	return Vector2(
		randf_range(global_position.x - width / 2, global_position.x + width / 2),
		randf_range(global_position.y - height / 2, global_position.y + height / 2)
	)

#Fonction pour obtenir une position aléatoire en dehors de la vue de la caméra
# Fonction pour obtenir une position aléatoire dans "Water", hors de la vue de la caméra
func get_random_position_in_water_outside_camera_view(margin: float = 100.0) -> Vector2:
	# Récupérer les dimensions de "Water"
	var texture_size = water_area.texture.get_size() # Taille de la texture
	# var scale = water_area.scale # Échelle appliquée au sprite
	# var global_position = water_area.global_position # Position globale du sprite
	
	# Calculer les dimensions réelles avec l'échelle
	var width = texture_size.x * scale.x
	var height = texture_size.y * scale.y

	# Obtenir les limites de "Water"
	var water_rect = Rect2(
		global_position - Vector2(width, height) / 2,
		Vector2(width, height)
	)

	# Récupérer les limites visibles de la caméra avec la marge
	var camera_rect = camera.get_camera_rect()
	camera_rect.position -= Vector2(margin, margin) # Étendre la zone de la caméra
	camera_rect.size += Vector2(margin * 2, margin * 2)
	
	# Générer une position dans "Water" mais en dehors de la vue de la caméra
	# var position = Vector2()
	while true:
		position = Vector2(
			randf_range(water_rect.position.x, water_rect.position.x + water_rect.size.x),
			randf_range(water_rect.position.y, water_rect.position.y + water_rect.size.y)
		)
		# Vérifier que la position est en dehors de la caméra
		if not camera_rect.has_point(position):
			break
	return position

func StartEndGame() -> void:
	$BubbleTransitionScreen/GPUParticles2D.emitting = true
	get_node("/root/Node/Background/Ambiance").stop()
	get_node("/root/Node/Background/IngameMusic").stop()
	get_node("/root/Node/Background/GameOver").play()
	var endGameTimer = Timer.new()
	endGameTimer.wait_time = 2.0
	endGameTimer.one_shot = true
	endGameTimer.connect("timeout", Callable(self, "EndGame"))
	add_child(endGameTimer)
	endGameTimer.start()

func EndGame() -> void:
	get_tree().change_scene_to_file(GameOverScreen);
