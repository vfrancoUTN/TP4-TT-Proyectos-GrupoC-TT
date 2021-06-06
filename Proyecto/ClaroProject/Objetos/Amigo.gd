extends Area

func _on_Amigo_body_entered(body):
	if body.has_method("ganar"):
		body.ganar()
