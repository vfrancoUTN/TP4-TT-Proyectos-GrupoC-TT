extends Button

onready var barraBrillo = get_node("../BarraBrillo")
onready var efectosVisuales = get_tree().get_nodes_in_group("EfectosVisuales")[0]

func _pressed():
	barraBrillo.set_value(barraBrillo.get_value() + barraBrillo.step)
	var barraBrilloValor = barraBrillo.value
	efectosVisuales.get_environment().set_adjustment_brightness(barraBrilloValor)

