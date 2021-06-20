extends Control

#
#hide() desactiva el nodo

func _on_Opcion_1_pressed():
	get_tree().change_scene("res://Interfaz/PantallaDerrota.tscn")
	hide() # Replace with function body.


func _on_Opcion_2_pressed():
	get_tree().change_scene("res://Interfaz/PantallaDerrota.tscn")
	hide() # Replace with function body


func _on_Opcion_3_pressed():
	get_tree().paused == false
	hide() # Replace with function body.
