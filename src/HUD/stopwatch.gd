extends Node2D

var secondeTotal: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	secondeTotal =secondeTotal+1
	
	var Minute = int(secondeTotal/60)
	var seconde = int(secondeTotal%60)
	var StrMinute = "00"
	var StrMSeconde = "00"
	
	if(Minute<10):
		StrMinute = "0" + str(Minute)
	else:
		StrMinute = str(Minute)
	
	if(seconde<10):
		StrMSeconde = "0" + str(seconde)
	else:
		StrMSeconde = str(seconde)
	
	$TimerLabel.text = StrMinute + ":"+StrMSeconde
	pass # Replace with function body.
