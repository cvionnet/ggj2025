extends Node2D

var direction := 1 # Direction initiale : 1 = droite, -1 = gauche

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Exclamation.visible = false
	$AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_safe_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Fart"):
		$Exclamation.visible = true
		get_node("/root/Node/Background/Lifeguard").pitch_scale = randf_range(0.85, 1.15)
		get_node("/root/Node/Background/Lifeguard").play()

func _on_safe_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Fart"):
		$Exclamation.visible = false
