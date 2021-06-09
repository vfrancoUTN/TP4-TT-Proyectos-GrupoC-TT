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
		colisionDetectada = get_collider().get_parent()
		if colisionDetectada.is_in_group("Notas"):
			jugador.popupNota()
		if colisionDetectada.is_in_group("Puertas"):
			jugador.popupPuerta()
		else:
			jugador.cerrarPanel()
	else:
		jugador.cerrarPanel()
