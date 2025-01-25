extends ProgressBar


#*--    HEADER    ----------------------------------------------------------*//
var FartMana = 0  # Mana de prout initiale
@export var FartReload = 1  # recharge de prout initiale
@export var FartExpulsion = 5  # expulstionde prout initiale
@export var TimeFartLoad = 0.1
var is_fart_active = false
var is_fart_malus_active = false

#*--    SIGNAL -------*//
signal FartManaDisponible(IsDisponible)
signal FartMalus(IsActif)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node('/root').find_child("Player", true, false)
	$Bubbles/GPUParticles2D
	player.connect("start_fart_drain", Callable(self, "_on_start_fart_drain"))
	player.connect("stop_fart_drain", Callable(self, "_on_stop_fart_drain"))
	stop_draining_fact();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//

func _on_start_fart_drain():
	is_fart_active = true
	start_draining_fact()

func _on_stop_fart_drain():
	is_fart_active = false
	stop_draining_fact()

func start_draining_fact():
	# Boucle pour vider la mana tant que le bouton est maintenu
	while (is_fart_active or is_fart_malus_active) and FartMana > 0:
		FartMana -= FartExpulsion  # Réduit la mana
		value = FartMana  # Met à jour la barre (ajuste selon ton ProgressBar)
		await get_tree().create_timer(TimeFartLoad).timeout  # Attente de 0.1 seconde
	
	emit_signal("FartManaDisponible", FartMana>1)
	if(is_fart_malus_active):
		is_fart_malus_active = false
		emit_signal("FartMalus", is_fart_malus_active)
		stop_draining_fact()
	



func stop_draining_fact():
	emit_signal("FartManaDisponible", true)
	# Boucle pour vider la mana tant que le bouton est maintenu
	while is_fart_active==false and FartMana <= 100:
		FartMana += FartReload  # Réduit la mana
		value = FartMana  # Met à jour la barre (ajuste selon ton ProgressBar)
		await get_tree().create_timer(TimeFartLoad).timeout  # Attente de 0.1 seconde
	
	if(FartMana>100):
		trigger_malus()


func spawn_bubble_particles():
	# Ajoute des particules de bulles pour animer la barre
	#var particles = FartBubble_particle_scene.instantiate()
	#particles.global_position = global_position + Vector2(randi() % rect_size.x, -10)
	#get_tree().current_scene.add_child(particles)
	
	pass


func trigger_malus():
	# Crée un effet d'explosion
	#var explosion = explosion_scene.instantiate()
	#explosion.global_position = global_position  # Place l'explosion sur la barre
	#get_tree().current_scene.add_child(explosion)
	is_fart_malus_active = true
	emit_signal("FartMalus", is_fart_malus_active)
	start_draining_fact();
	# Déclenche le Game Over
	print("Malus! Trop de pression !")
	#get_tree().reload_current_scene()
