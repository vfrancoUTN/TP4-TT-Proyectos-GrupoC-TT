extends KinematicBody

export (float) var velocidad
var posObjetivo = Vector3()
var navegacion = Navigation
var recorrido = []

func _ready():
	set_physics_process(true)
	navegacion = get_tree().get_nodes_in_group("Navegacion")[0]
	posObjetivo = get_tree().get_nodes_in_group("Objetivo")[0].get_pos()
	recorrido = navegacion.get_simple_path(global_transform.origin, posObjetivo, false)
	
func _physics_process(delta):
	if recorrido.size() > 1:
		var d = global_transform.origin.distance_to(recorrido[0])
		if d > 2:
			global_transform.origin = global_transform.origin.linear_interpolate(recorrido[0], (velocidad*delta)/d)
		else:
			recorrido.remove(0)
			
func setearRecorrido():
	get_tree().get_nodes_in_group("Objetivo")[0].set_pos()
	posObjetivo = get_tree().get_nodes_in_group("Objetivo")[0].get_pos()
	recorrido = navegacion.get_simple_path(global_transform.origin, posObjetivo, false)









