extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$General/Score.text = "Quoi ?! 
	T’as osé rester " + Global.StrScoreMinuteSeconde +" à faire ça dans MA piscine ?!
	Tu crois que je vais te laisser transformer ce bassin en bain à bulles ?! 
	Dehors, et que je ne te revoie plus jamais ici !"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
