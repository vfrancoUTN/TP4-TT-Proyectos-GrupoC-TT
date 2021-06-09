extends RayCast

onready var nota
onready var jugador = $"../../.."
onready var popup
onready var textoPopup

func _ready():
	popup = jugador.getPopup()
	textoPopup = jugador.getTextoPopup()

var colisionDetectada;

func _process(delta):
	if is_colliding():
		colisionDetectada = get_collider()
		if colisionDetectada.get_node().is_in_group("Notas"):
			jugador.popupNota()
		if colisionDetectada.get_node().is_in_group("Puertas"):
			jugador.popupPuerta()
		else:
			if popup.is_visible_in_tree() == true:
				popup.is_visible_in_tree() == false
	else:
		jugador.cerrarPanel()
