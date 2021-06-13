extends Control

onready var jugador = get_tree().get_nodes_in_group("Jugador")[0]
onready var nota1 = $CenterContainer/VBoxContainer/Nota1

func _ready():
	hide()

func mostrarNotas():
	if jugador.getNotas().size() != 0:
		nota1.text = jugador.getNotas()[0]
		#Esto deberia setear el texto de la label nota al valor string de la nota que el jugador tiene en inventario pero no funciona. ARREGLAR
	
func _on_BotonNotas_pressed():
	mostrarNotas()
	show()

func _on_BotonVolver_pressed():
	hide()
