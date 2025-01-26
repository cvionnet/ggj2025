extends Node2D

var Game = "res://src/main/Game.tscn"

@export var full_text: String = "Gstaad municipal swimming pool, 1999.
A man and his environment, as one.
A shadow in the water, a passing scent most elusive in the wind.
The Fart... must remain stealthy.

Fart as much as you can while staying away from other people."  # Texte complet à afficher
@export var typing_speed: float = 0.015  # Vitesse d'affichage des lettres (en secondes)

signal EndText()

var current_text: String = ""  # Texte affiché actuellement

func _ready():
	$TitleLabel.text = ""  # Initialise le texte à vide
	show_text_letter_by_letter(full_text)  # Appelle la méthode pour afficher le texte progressivement

func show_text_letter_by_letter(text: String) -> void:
	# Affiche le texte lettre par lettre
	current_text = ""
	for i in range(text.length()):
		current_text += text[i]
		$TitleLabel.text = current_text
		await get_tree().create_timer(typing_speed).timeout  # Pause avant d'ajouter la lettre suivante
	await get_tree().create_timer(2.5).timeout 
	emit_signal("EndText")
	
