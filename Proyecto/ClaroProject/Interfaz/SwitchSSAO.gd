extends CheckButton

onready var boton = get_node(".")
onready var efectosVisuales = get_tree().get_nodes_in_group("EfectosVisuales")[0]

func _pressed():
	if boton.is_pressed() == true:
		efectosVisuales.get_environment().ssao_enabled = true
	elif boton.is_pressed() == false:
		efectosVisuales.get_environment().ssao_enabled = false
