extends Button

onready var barraVolumen = get_node("../BarraVolumen")

func _pressed():
	barraVolumen.set_value(barraVolumen.get_value() - barraVolumen.step)
	var barraVolumenValor = barraVolumen.value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), barraVolumenValor)
