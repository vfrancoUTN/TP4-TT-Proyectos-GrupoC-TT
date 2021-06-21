extends Area

onready var puzzle = $"../Puzzle1"
onready var puzzle1C = $"../Puzzle_1C"
onready var puzzle1B = $"../Puzzle1_B"


#var rng = RandomNumberGenerator.new()
#var numAleatorio
var secuencial=0
var atrapadas = 4

func _on_Trampa_body_entered(body):
	atrapadas = atrapadas - 1
	secuencial+=1
	if atrapadas == 0:
		if body.has_method("morir"):
			body.morir()
	
	get_tree().paused == true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#numAleatorio = rng.randi_range(1,3)
	if secuencial == 1 :
		puzzle.setPuzzle(true)
		puzzle.show()
	if secuencial == 2:
		puzzle1B.setPuzzle(true)
		puzzle1B.show()
	if secuencial == 3:
		puzzle1C.setPuzzle(true)
		puzzle1C.show()
