extends Control



func _on_ToolButton_pressed():
	get_tree().change_scene("res://Interfaz/lobby.tscn")


func _on_Salir_pressed():
	get_tree().quit()
