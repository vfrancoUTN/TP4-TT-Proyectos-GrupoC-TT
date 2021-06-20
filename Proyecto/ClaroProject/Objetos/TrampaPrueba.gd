extends Area

func _on_Trampa_body_entered(body):
	get_tree().paused == true
	$"../Puzzle1".show()
