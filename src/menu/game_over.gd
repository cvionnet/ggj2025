extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$General/Score.text = "Alright, listen up, champ.
	You tryna be sneaky but it's been " + Global.StrScoreMinuteSeconde +" I caught you turning this pool into a jaccuzzi.
	I'll need you to haul your nasty ass from here to the doctor's office.
	Like, for real bro."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
