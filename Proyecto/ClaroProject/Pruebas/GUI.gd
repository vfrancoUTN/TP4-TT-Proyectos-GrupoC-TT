extends Control

onready var tiempoLabel : = $CenterContainer/VBoxContainer/Tiempo
onready var jugador

var menuActivo = false

func _ready():
	jugador = get_tree().get_nodes_in_group("Jugador")[0]
	hide()

func activarMenu(tiempo : float):
	menuActivo = true
	jugador.activarPausa()
	mostrarStats(tiempo)
	show()

func mostrarStats(tiempo : float):
	var minutos : String = str(int(tiempo / 60.0))
	var segundos : String = str(int(fmod(tiempo, 60.0)))
	var textoTiempo = "Tiempo transcurrido: %s m %s s" % [minutos, segundos]
	tiempoLabel.text = textoTiempo

func _on_Button2_pressed():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://Interfaz/PantallaInicio.tscn")


func _on_BotonVolver_pressed():
	menuActivo = false
	hide()
	jugador.desactivarPausa()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().set_input_as_handled()

func getActivo():
	return menuActivo

func setActivo(condicion : bool):
	menuActivo = condicion

