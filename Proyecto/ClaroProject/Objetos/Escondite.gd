extends Area



func _on_Escondite_body_entered(body):
	if body.has_method("activarEscondite"):
		body.activarEscondite()



func _on_Escondite_body_exited(body):
	if body.has_method("desactivarEscondite"):
		body.desactivarEscondite()
