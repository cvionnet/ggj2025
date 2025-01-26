extends Label

@export var fade_in_duration: float = 2.0  # Durée du fade-in en secondes
@export var blink_duration: float = 1.0  # Temps d'une boucle de clignotement (on/off)
var opacity: float = 1.0  # Opacité actuelle


var blink_tween: Tween = null  # Stocke le Tween utilisé pour le clignotement

func _ready():
	# Démarre avec une opacité de 0 (invisible)
	modulate.a = 1.0
	# Lance le processus de fade-in
	fade_in()

func fade_in():
	# Interpolation progressive de l'opacité pour le fade-in
	#var fade_in_tween = get_tree().create_tween()
	#fade_in_tween.tween_property(self, "modulate:a", 1.0, fade_in_duration)
	#fade_in_tween.finished.connect(blink_start)  # Une fois le fade-in terminé, lance le clignotement
	pass

func blink_start():
	# Animation de clignotement cyclique
	#blink_tween = get_tree().create_tween()
	#blink_tween.set_loops()  # Boucle infinie
	 # L'opacité descend jusqu'à 0
	#blink_tween.tween_property(self, "modulate:a", 0.0, blink_duration / 2).as_relative()
	# Puis revient à 1
	#blink_tween.tween_property(self, "modulate:a", 1.0, blink_duration / 2).as_relative()
	pass

func stop_blinking():
	# Arrête le Tween de clignotement s'il existe
	#if blink_tween:
	#	blink_tween.stop()
	#	modulate.a = 1.0  # S'assure que le Label reste visible après l'arrêt
	#	blink_tween = null  # Libère la référence
	pass
