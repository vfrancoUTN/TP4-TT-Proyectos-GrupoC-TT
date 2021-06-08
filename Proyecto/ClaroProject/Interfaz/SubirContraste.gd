extends Button

onready var barraContraste = get_node("../BarraContraste")
onready var efectosVisuales = get_tree().get_nodes_in_group("EfectosVisuales")[0]

func _pressed():
	barraContraste.set_value(barraContraste.get_value() + barraContraste.step)
	var barraContrasteValor = barraContraste.value
	efectosVisuales.get_environment().set_adjustment_contrast(barraContrasteValor)
