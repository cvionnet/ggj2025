extends Node

# Variables pour l'oscillation
var oscillation_amplitude = 45  # Angle maximum d'oscillation en degrés
var oscillation_speed = 30     # Vitesse d'oscillation (degrés par seconde)
var oscillation_duration = 2   # Durée de l'oscillation complète

# Chaque enfant aura son propre angle initial et ses propres paramètres d'oscillation
var child_oscillation_params = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialisation des paramètres d'oscillation pour chaque enfant
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is Node2D:
			var child_params = {
				"initial_angle": child.rotation,  # Angle initial de l'enfant
				"oscillation_amplitude": randf_range(30, 60),  # Amplitude aléatoire pour chaque enfant
				"oscillation_duration": randf_range(1.5, 3.0),  # Durée d'oscillation aléatoire
				"oscillation_speed": randf_range(5, 25)  # Vitesse d'oscillation aléatoire
			}
			child_oscillation_params.append(child_params)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Appliquer l'oscillation à chaque enfant
	for i in range(get_child_count()):
		var child = get_child(i)
		if child is Node2D:
			var params = child_oscillation_params[i]
			var rotation_progress = fmod((Time.get_ticks_msec() / 1000.0), params["oscillation_duration"]) / params["oscillation_duration"]
			
			# Calcul de l'angle d'oscillation basé sur une fonction sinus
			var angle = sin(rotation_progress * 2 * PI) * params["oscillation_amplitude"]  # Oscillation de -amplitude à +amplitude
			# Appliquer la rotation calculée à l'enfant en fonction de son angle initial
			child.rotation = params["initial_angle"] + deg_to_rad(angle)
