extends ProgressBar


#*--    HEADER    ----------------------------------------------------------*//
var FartMana = 0  # Mana de prout initiale
@export var FartReload = 1  # recharge de prout initiale
@export var FartExpulsion = 5  # expulstionde prout initiale
var is_fart_active = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node('/root').find_child("Player", true, false)
	player.connect("start_fart_drain", Callable(self, "_on_start_fart_drain"))
	player.connect("stop_fart_drain", Callable(self, "_on_stop_fart_drain"))
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
	while is_fart_active and FartMana > 0:
		FartMana -= FartExpulsion  # Réduit la mana
		value = FartMana  # Met à jour la barre (ajuste selon ton ProgressBar)
		await get_tree().create_timer(0.1).timeout  # Attente de 0.1 seconde



func stop_draining_fact():
	# Boucle pour vider la mana tant que le bouton est maintenu
	while is_fart_active==false and FartMana <= 100:
		FartMana += FartReload  # Réduit la mana
		value = FartMana  # Met à jour la barre (ajuste selon ton ProgressBar)
		await get_tree().create_timer(0.1).timeout  # Attente de 0.1 seconde
