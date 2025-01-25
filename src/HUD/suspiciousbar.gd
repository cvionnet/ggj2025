extends ProgressBar


#*--    HEADER    ----------------------------------------------------------*//
var SouspiciousScrore = 0  # Scrore de suspicious
@export var ScroreSoundIsDetected =2
@export var ScroreSmellIsDetected =1

#*--    SIGNAL -------*//


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node('/root').find_child("Player", true, false)
	player.connect("sound_of_fart_is_detected", Callable(self, "_on_sound_of_fart_is_detected"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//

func _on_sound_of_fart_is_detected():
	SouspiciousScrore = SouspiciousScrore + ScroreSoundIsDetected 
	print("Scrore : " + str(SouspiciousScrore))
	value = SouspiciousScrore
	ValidationScore()




func ValidationScore():
	if( SouspiciousScrore>= max_value):
		print("Game over")
