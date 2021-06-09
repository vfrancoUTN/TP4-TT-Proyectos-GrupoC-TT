extends StaticBody

onready var nota = $NotaInfo.notaInfo

func _on_Area_body_entered(body):
	if body.has_method("agarrarNota"):
		if Input.is_action_pressed("Agarrar"):
			body.agarrarNota(nota)
			if body.has_method("inhabilitarUI"):
				body.inhabilitarUI()
			get_node("Sonido").play()
			queue_free()

