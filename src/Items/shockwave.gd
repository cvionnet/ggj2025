extends Node2D

func _ready() -> void:
	$".".visible = false

func _process(_delta: float) -> void:
	pass

func FartActif(FartIsActif) -> void:
	if FartIsActif && !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("expand")