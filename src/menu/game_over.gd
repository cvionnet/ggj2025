extends Node2D

var Titre = "res://src/menu/Titre/Titre.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$General/Score.text = "Alright, listen up, champ.
You tryna be sneaky but it's been " + Global.StrScoreMinuteSeconde +" 
I caught you turning this pool into a jaccuzzi.
Haul your nasty ass from here to the doctor's office!

Like, for real bro."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("start") or event.is_action_pressed("button_A") :  # "ui_accept" est la touche par défaut pour Enter/Space
		StartGame()



func StartGame() -> void:
	$BubbleTransitionScreen/GPUParticles2D.emitting = true
	var GameTimer = Timer.new()
	GameTimer.wait_time = 4.0
	GameTimer.one_shot = true
	GameTimer.connect("timeout", Callable(self, "change_scene"))
	add_child(GameTimer)
	GameTimer.start()

func change_scene():
	get_tree().change_scene_to_file(Titre);
