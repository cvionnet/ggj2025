extends Control

#*--    HEADER    ----------------------------------------------------------*//

#*--------------------------------------------------------------------------*//
#*--    GODOT METHODS    ---------------------------------------------------*//

# Called when the node enters the scene tree for the first time
func _ready():
	get_node("Label").text = ""
	
	var player = get_node('/root').find_child("Player", true, false)
	player.connect("display_key", Callable(self, "_on_Display_Key"))


#*--------------------------------------------------------------------------*//
#*--    SIGNAL CALLBACKS    ------------------------------------------------*//

func _on_Display_Key(key):
	get_node("Label").text = key
	print(key)


#*--------------------------------------------------------------------------*//
#*--    USER METHODS    ----------------------------------------------------*//

#*--------------------------------------------------------------------------*//
