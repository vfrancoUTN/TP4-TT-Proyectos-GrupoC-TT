extends StaticBody



func _on_Area_body_entered(body):
	if body.has_method("getLlaves"):
		if body.getLlaves() > 0:
			body.perderLlave()
			queue_free()
