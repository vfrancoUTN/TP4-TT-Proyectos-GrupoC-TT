extends StaticBody



func _on_Area_body_entered(body):
	if body.has_method("getLlaves"):
		if body.getLlaves() > 0:
			if body.has_method("perderLlave"):
				body.perderLlave()
				get_node("../../Sonidos/Puerta").play()
				queue_free()
