extends Node2D

var EcranTitre = "res://src/menu/Titre/Titre.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BackgroundNoirEtBlanc.visible = true
	$BackgroundCouleur.visible = false
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ArcEnCiel.position.y = $ArcEnCiel.position.y + 20

	if($ArcEnCiel.position.y>1050):
		$BackgroundCouleur.visible = true
		$BackgroundNoirEtBlanc.visible = true
	pass


func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("start") or event.is_action_pressed("button_A") :  # "ui_accept" est la touche par défaut pour Enter/Space
		$SonIntro.stop()
		_on_son_intro_finished()


func _on_son_intro_finished() -> void:
	get_tree().change_scene_to_file(EcranTitre);
	pass # Replace with function body.
