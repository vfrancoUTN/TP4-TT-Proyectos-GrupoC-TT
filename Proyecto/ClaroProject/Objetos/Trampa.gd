extends Area

func _on_Trampa_body_entered(body):
	if body.has_method("morir"):
		body.morir()
