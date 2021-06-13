extends Button

onready var barraSaturacion = get_node("../BarraSaturacion")
onready var efectosVisuales = get_tree().get_nodes_in_group("EfectosVisuales")[0]

func _pressed():
	barraSaturacion.set_value(barraSaturacion.get_value() + barraSaturacion.step)
	var barraSaturacionValor = barraSaturacion.value
	efectosVisuales.get_environment().set_adjustment_saturation(barraSaturacionValor)

