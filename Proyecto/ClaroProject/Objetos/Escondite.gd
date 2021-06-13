extends Area



func _on_Escondite_body_entered(body):
	if body.has_method("activarEscondite"):
		body.activarEscondite()
	if body.has_method("activarRespiracion"):
		body.activarRespiracion()



func _on_Escondite_body_exited(body):
	if body.has_method("desactivarEscondite"):
		body.desactivarEscondite()
	if body.has_method("desactivarRespiracion"):
		body.desactivarRespiracion()
