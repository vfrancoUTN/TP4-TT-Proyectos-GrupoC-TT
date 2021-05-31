extends Area



func _on_Llave_body_entered(body):
	body.obtenerLlave()
	queue_free()
