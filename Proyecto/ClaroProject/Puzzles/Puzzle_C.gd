extends Control

onready var juego = $".."
 

func _on_Opcion_1_pressed():
	juego.enPuzzle = false
	get_tree().change_scene("res://Interfaz/PantallaDerrota.tscn")
	hide() # Replace with function body.


func _on_Opcion_2_pressed():
	juego.enPuzzle = false
	get_tree().change_scene("res://Interfaz/PantallaDerrota.tscn")
	hide() # Replace with function body


func _on_Opcion_3_pressed():
	juego.enPuzzle = false
	get_tree().paused == false
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
