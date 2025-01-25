extends CharacterBody2D


enum EnemyType { GRANNY, MUSCLE, LIFEGUARD, BOY }

@export var base_speed: float = 70.0  # Vitesse de déplacement
@export var enemy_type: EnemyType = EnemyType.GRANNY 
# Textures pour chaque type d'ennemi
@export var granny_texture: Texture2D
@export var muscle_texture: Texture2D
@export var lifeguard_texture: Texture2D
@export var boy_texture: Texture2D

# Référence au sprite
@onready var sprite = $Sprite2D
@onready var area_detection = $SafeZone  

var HorizontalDirection: float = 0 # 1 vers la droite, -1 vers la gauche
var VerticalDirection: float = 0 # 1 vers le haut , -1 vers la bas
var direction: Vector2 = Vector2(HorizontalDirection, VerticalDirection)  # Direction initiale
var change_direction_timer: float = 0.0  # Timer pour adoucir les changements de direction

func _ready():
	add_to_group("enemy")
	#area_detection.connect("body_entered", Callable( self, "_on_safe_zone_body_entered"))
	#area_detection.connect("body_exited", Callable( self, "_on_safe_zone_body_exited"))
	print("Ennemi prêt : ", self.name, "Type :", enemy_type)
	configure_enemy()
	direction = Vector2(HorizontalDirection, VerticalDirection)

# === Configuration de l'ennemi (texture et paramètres) ===

func configure_enemy():
	match enemy_type:
		EnemyType.GRANNY:
			sprite.texture = granny_texture
			HorizontalDirection = 1
			VerticalDirection = 0
		EnemyType.MUSCLE:
			sprite.texture = muscle_texture
			HorizontalDirection = 0
			VerticalDirection = 1
		EnemyType.LIFEGUARD:
			sprite.texture = lifeguard_texture
			HorizontalDirection = 0
			VerticalDirection = 0
		EnemyType.BOY:
			sprite.texture = boy_texture
			HorizontalDirection = 0.5
			VerticalDirection = 0.5
		_:
			print("Type d'ennemi inconnu :", enemy_type)
			HorizontalDirection = 0
			VerticalDirection = 0

func _physics_process(delta):
	# Appelle le pattern spécifique à l'ennemi
	match enemy_type:
		EnemyType.GRANNY:
			move_granny(delta)
		EnemyType.MUSCLE:
			move_muscle(delta)
		EnemyType.LIFEGUARD:
			move_lifeguard(delta)
		EnemyType.BOY:
			move_boy(delta)
		_:
			move_default(delta)
	sprite.rotation = velocity.angle() + deg_to_rad(-90)  # Ajoute 90° en radians


# ==  Option selonType

func get_speed() -> float:
	match enemy_type:
		EnemyType.GRANNY:
			return base_speed * 0.5  # Granny est lente
		EnemyType.MUSCLE:
			return base_speed * 1.5  # Muscle est rapide
		EnemyType.LIFEGUARD:
			return base_speed * 1  # Lifeguard a une vitesse moyenne
		EnemyType.BOY:
			return base_speed * 2.0  # Boy est très rapide
		_:
			return base_speed  # Vitesse par défaut


func get_X() -> float:
	match enemy_type:
		EnemyType.GRANNY:
			return base_speed * 0.5  # Granny est lente
		EnemyType.MUSCLE:
			return base_speed * 1.5  # Muscle est rapide
		EnemyType.LIFEGUARD:
			return base_speed * 0  # Lifeguard a une vitesse moyenne
		EnemyType.BOY:
			return base_speed * 0.75  # Boy est plus lent
		_:
			return base_speed  # Vitesse par défaut


# === Patterns de déplacement ===

func move_granny(delta):
	# Granny : Se déplace lentement en petit zigzag
	var zigzag_direction = Vector2(direction.x, sin(1 * PI * Time.get_ticks_msec() / 1000.0)) 
	velocity = zigzag_direction * get_speed() 
	move_and_slide()

func move_muscle(delta):
	# Muscle : Charge rapidement, puis ralentit
	#if randi() % 100 < 5:  # Change de direction aléatoirement parfois
		#direction = Vector2(direction.x, randf() * 2 - 1).normalized()
	velocity = direction * get_speed() 
	move_and_slide()

func move_lifeguard(delta):
	# Lifeguard : Se déplace en zigzag
	#var zigzag_direction = Vector2(direction.x, sin(2 * PI * Time.get_ticks_msec() / 1000.0))
	velocity = direction.normalized() * get_speed() 
	move_and_slide()

func move_boy(delta):
	# Boy : Changement de direction plus smooth
	change_direction_timer -= delta  # Décrémente le timer à chaque frame

	# Si le timer est écoulé, change de direction et réinitialise le timer
	if change_direction_timer <= 0.0:
		direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()  # Nouvelle direction aléatoire
		change_direction_timer = randf_range(1.0, 3.0)  # Timer pour le prochain changement (1 à 3 secondes)

	# Lerp entre l'ancienne direction et la nouvelle direction pour un mouvement plus smooth
	velocity = direction.lerp(direction, 0.1) * get_speed()  # Ajuste la valeur pour plus ou moins de smoothness
	move_and_slide()

func move_default(delta):
	# Déplacement par défaut (si aucun type spécifique)
	velocity = direction* get_speed() 
	move_and_slide()

#===  Collition =====
func _on_safe_zone_body_entered(body: Node):
	# Si un autre ennemi ou un mur entre dans la zone de détection, l'ennemi fait demi-tour
	if body.is_in_group("enemy") or body.is_in_group("wall"):
		direction = -direction  # Inverse la direction pour faire demi-tour
		#print("Collision avec un ennemi ou un mur, demi-tour!")

func _on_safe_zone_body_exited(body: Node):
	# Si un autre ennemi ou un mur quitte la zone, tu peux réagir ici si nécessaire.
	pass
