extends Area



func _on_Llave_body_entered(body):
	if body.has_method("obtenerLlave"):
		body.obtenerLlave()
		get_node("../../Sonidos/Llave").play()
		queue_free()
