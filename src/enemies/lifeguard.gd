extends Node2D

var direction := 1  # Direction initiale : 1 = droite, -1 = gauche

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
