extends Node2D

var direction := 1  # Direction initiale : 1 = droite, -1 = gauche

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Alerte.visible = false
	pass # Replace with function body.
	$AnimationPlayer.play("walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_safe_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Fart"):
		$Alerte.visible = true
	pass # Replace with function body.


func _on_safe_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Fart"):
		$Alerte.visible = false
	pass # Replace with function body.
