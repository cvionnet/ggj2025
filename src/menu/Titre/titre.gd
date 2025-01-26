extends Node2D

var Game = "res://src/main/Game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("start") or event.is_action_pressed("button_A") :  # "ui_accept" est la touche par défaut pour Enter/Space
		StartGame()


func change_scene():
	# Remplace par le chemin de ta scène cible
	get_tree().change_scene_to_file(Game);


func _on_timer_timeout() -> void:
	$General/PressStart.blink_start()
	pass # Replace with function body.


func StartGame() -> void:
	$BubbleTransitionScreen/GPUParticles2D.emitting = true
	var GameTimer = Timer.new()
	GameTimer.wait_time = 2.0
	GameTimer.one_shot = true
	GameTimer.connect("timeout", Callable(self, "change_scene"))
	add_child(GameTimer)
	GameTimer.start()
