extends CheckButton

onready var boton = get_node(".")
onready var efectosVisuales = get_tree().get_nodes_in_group("EfectosVisuales")[0]

func _pressed():
	if boton.is_pressed() == true:
		efectosVisuales.get_environment().dof_blur_near_enabled = true
	elif boton.is_pressed() == false:
		efectosVisuales.get_environment().dof_blur_near_enabled = false
