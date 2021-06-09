extends StaticBody

onready var nota = $NotaInfo.notaInfo
onready var jugador

var agarrable = false

func _ready():
	jugador = null

func _process(delta):
	if agarrable:
		if jugador != null:
			if jugador.has_method("agarrarNota"):
				if Input.is_action_just_pressed("Agarrar"):
					jugador.agarrarNota(nota)
					if jugador.has_method("inhabilitarUI"):
						jugador.inhabilitarUI()
					get_node("Sonido").play()
					queue_free()

func _on_Area_body_entered(body):
	jugador = body
	agarrable = true

func _on_Area_body_exited(body):
	jugador = null
	agarrable = false
