extends CharacterBody2D


#*--    HEADER    ----------------------------------------------------------*//

@export var speed: float = 100.0
@export var speedRun: float = 20.0
@export var inertia: float = 0.15 # proche 0.0 = déplacement "lourd"  /  proche 1.0 = déplacement aérien

@onready var sprite = $Sprite2D

# Déclaration des signaux
signal start_fart_drain()
signal stop_fart_drain()
signal display_key(key)
signal sound_of_fart_is_detected()

var direction: Vector2 = Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO

var run: Vector2 = Vector2(1.0, 1.0)


#  Actions #
var move_fart_action := "button_A"
var move_left_action := "L_left"
var move_right_action := "L_right"
var move_up_action := "L_up"
var move_down_action := "L_down"
var hit_action := "button_X"
var dash_action := "button_B"
var change_state_up_action := "trigger_RB"
var change_state_down_action := "trigger_LB"

# Animations #
var jump_animation := "jump"
var run_animation := "run"
var idle_animation := "idle"
var hit_animaton := "hit"
var hurt_animation := "hurt"
var dying_animation := "dying"

# State #
var FartManaDisponible := false
var FartMalus := false

#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//


# Not synced with physics. Execution done after the physics step
func _process(_delta):
	pass

func _ready() -> void:
	var Fartbar = get_node('/root').find_child("Fartbar", true, false)
	Fartbar.connect("FartManaDisponible", Callable(self, "_on_FartManaDisponible"))
	Fartbar.connect("FartMalus", Callable(self, "_on_FartMalus"))
	FartAction(FartMalus)


# For processes that must happen before each physics step, such as controlling a character
func _physics_process(_delta):
	
	
	if FartMalus == false:
		direction = Vector2(
			Input.get_action_strength(move_right_action) - Input.get_action_strength(move_left_action),
			Input.get_action_strength(move_down_action) - Input.get_action_strength(move_up_action)
		)
		
		# Si le joueur lache un pet
		if Input.is_action_just_pressed(move_fart_action):
			StartFartAction()
		
		# Si le joueur arrete de lache un pet
		if Input.is_action_just_released(move_fart_action):
			StopFartAction()
		
	else:
		# Si FartMalus est actif, on garde la direction actuelle et n'applique pas les entrées
		direction = Vector2.ZERO
	direction = direction.normalized()
	
	# Si le joueur cest en train de peter et qu'il a du gazz
	if Input.is_action_pressed(move_fart_action) and FartManaDisponible == true:
		run = Vector2(speedRun, speedRun) / 9.0
	else:
		run = Vector2(1.0, 1.0)
	
	_velocity = lerp(_velocity, direction * speed * run, inertia)
	
	sprite.rotation = _velocity.angle() + deg_to_rad(-90) # Ajoute 90° en radians

	set_velocity(_velocity)
	move_and_slide()


#*--------------------------------------------------------------------------*//
#*--    SIGNAL CALLBACKS    ------------------------------------------------*//
func _on_FartManaDisponible(_FartManaDisponible) -> void:
	FartManaDisponible = _FartManaDisponible

func _on_FartMalus(_FartMalus) -> void:
	FartMalus = _FartMalus
	FartAction(FartMalus)


func _on_fart_noise_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		emit_signal("sound_of_fart_is_detected")
		print("Le sond du prout is dectected")
	pass # Replace with function body.

#*--------------------------------------------------------------------------*//
#*--    USER METHODS    ----------------------------------------------------*//

func StartFartAction() -> void:
	emit_signal("start_fart_drain")
	FartAction(true);
	pass

func FartAction(IsFartActif) -> void:
	$FartNoiseArea.set_detection_active(IsFartActif)
	$"Bubble-back".FartActif(IsFartActif)
	$"Bubble-front".FartActif(IsFartActif)
	

func StopFartAction() -> void:
	emit_signal("stop_fart_drain")
	FartAction(false);
	pass


#*--------------------------------------------------------------------------*//
