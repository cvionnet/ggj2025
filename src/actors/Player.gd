extends CharacterBody2D


#*--    HEADER    ----------------------------------------------------------*//

@export var speed: float = 50.0
@export var speedRun: float = 20.0
@export var inertia: float = 0.15 # proche 0.0 = déplacement "lourd"  /  proche 1.0 = déplacement aérien
@export var fart: float = 1
@export var suspection: float = 1



# Déclaration des signaux
signal start_fart_drain()
signal stop_fart_drain()
signal display_key(key)

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

#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//


# Not synced with physics. Execution done after the physics step
func _process(_delta):
	ReadInputs()




# For processes that must happen before each physics step, such as controlling a character
func _physics_process(_delta):
	direction = Vector2(
		Input.get_action_strength(move_right_action) - Input.get_action_strength(move_left_action),
		Input.get_action_strength(move_down_action) - Input.get_action_strength(move_up_action)
	)
	direction = direction.normalized()

	# Si le joueur lache un pet
	if Input.is_action_just_pressed(move_fart_action):
		emit_signal("start_fart_drain")
	
	# Si le joueur arrete de lache un pet
	if Input.is_action_just_released(move_fart_action):
		emit_signal("stop_fart_drain")
		
	# Si le joueur court
	#elif Input.is_action_pressed("button_B"):
	#	run = Vector2(speedRun, speedRun) / 9.0
	else:
		run = Vector2(1.0, 1.0)

	# Interprétation lineaire entre la dernière vélocité connue et la nouvelle pour rendre le déplacement plus "smooth"
	_velocity = lerp(_velocity, direction * speed * run, inertia)

	set_velocity(_velocity)
	move_and_slide()


#*--------------------------------------------------------------------------*//
#*--    SIGNAL CALLBACKS    ------------------------------------------------*//


#*--------------------------------------------------------------------------*//
#*--    USER METHODS    ----------------------------------------------------*//

func ReadInputs() -> void:
	var action: String = ""
	
	if (action != ""):
		emit_signal("display_key", action)


#*--------------------------------------------------------------------------*//
