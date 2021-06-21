extends Area

onready var puzzle = $"../Puzzle1"
onready var puzzle1C = $"../Puzzle_1C"
onready var puzzle1B = $"../Puzzle1_B"

var rng = RandomNumberGenerator.new()
var numAleatorio

func _on_Trampa_body_entered(body):
	get_tree().paused == true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	numAleatorio = rng.randi_range(1,3)
	if numAleatorio == 1 :
		puzzle.setPuzzle(true)
		puzzle.show()
	if numAleatorio == 2:
		puzzle1B.setPuzzle(true)
		puzzle1B.show()
	if numAleatorio == 3:
		puzzle1C.setPuzzle(true)
		puzzle1C.show()
