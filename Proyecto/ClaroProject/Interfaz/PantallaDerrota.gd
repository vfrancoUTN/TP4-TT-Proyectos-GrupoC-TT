extends Control

func _ready():
	Multijugador.jugando == false

func _on_ToolButton_pressed():
	get_tree().change_scene("res://Interfaz/PantallaInicio.tscn")


func _on_Salir_pressed():
	get_tree().quit()
