extends Node2D


#*--    HEADER    ----------------------------------------------------------*//
var SouspiciousScrore = 0.00  # Scrore de suspicious
var valueAlerte = 0.0
var valueAlerteScale = 0.0
@export var min_angle := -135.0  # Angle minimum (gauche)
@export var max_angle := 50.0   # Angle maximum (droite)
@export var min_value := 0.00      # Valeur minimale (ex. 0 %)
@export var max_value := 20.00     # Valeur maximale (ex. 100 %)
@export var ScroreSoundIsDetected =2.00
@export var ScroreSmellIsDetected =1.00


var current_pressure = 0.0  # Valeur courante de pression (pour montée progressive)
@export var pressure_speed := 1.00  # Vitesse de montée vers la valeur cible
@export var oscillation_amplitude := 0.00  # Amplitude de l'oscillation
@export var oscillation_speed := 0.01  # Vitesse de l'oscillation
#*--    SIGNAL -------*//
signal GameOver()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node('/root').find_child("Player", true, false)
	player.connect("sound_of_fart_is_detected", Callable(self, "_on_sound_of_fart_is_detected"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Met à jour l'angle en fonction d'une valeur variable
	update_pressure(delta)  # Valeur oscillante

#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//

func _on_sound_of_fart_is_detected():
	SouspiciousScrore = SouspiciousScrore + ScroreSoundIsDetected
	ValidationScore()
	
	# Met à jour la pression en montant progressivement et en oscillant
func update_pressure(delta: float):
	# Monte progressivement vers la pression cible
	current_pressure = lerp(current_pressure, SouspiciousScrore, delta * pressure_speed)
	# Ajoute une oscillation aléatoire autour de la valeur cible
	var noise = randf_range(-oscillation_amplitude, oscillation_amplitude) * sin(Time.get_ticks_msec() * oscillation_speed * 0.001)
	var displayed_pressure = clamp(current_pressure + noise, min_value, max_value)
	
	# Calcule et applique l'angle
	set_pressure(displayed_pressure)
	alerte()

# Fonction pour mettre à jour l'angle en fonction de la valeur
func set_pressure(value: float):
	# Limite la valeur entre les bornes min et max
	value = clamp(value, min_value, max_value)  
	# Calcule la progression (entre 0 et 1)
	var t = (value - min_value) / (max_value - min_value)  
	# Interpole l'angle en fonction de la progression
	var angle = lerp(min_angle, max_angle, t)  
	$needle.rotation_degrees = angle  # Applique la rotation

func alerte():
	if(SouspiciousScrore+4>= max_value):
		if(valueAlerteScale >= 0.1):
			valueAlerte =-0.01
		if(valueAlerteScale<= 0):
			valueAlerte =0.01
		valueAlerteScale = valueAlerteScale + valueAlerte
		scale.x = scale.x +valueAlerte
		scale.y = scale.x +valueAlerte


func ValidationScore():
	if(SouspiciousScrore>= max_value):
		emit_signal("GameOver")
