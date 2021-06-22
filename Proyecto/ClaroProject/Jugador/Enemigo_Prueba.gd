extends KinematicBody

export (float) var velocidad
export (int) var distanciaPerseguidor = 10
onready var pisadas = $Pisadas
onready var puzzle1C = $"../../Puzzle_1C"
onready var puzzle1B = $"../../Puzzle_1B"
onready var puzzle2C = $"../../Puzzle_2C"

var posObjetivo = Vector3()
var navegacion = Navigation
var puntosLlegada = PoolVector3Array()
var recorrido = []
var indice = 0
var jugador = KinematicBody
var moviendose = false

var atrapadas = 0

func _ready():
	jugador = get_tree().get_nodes_in_group("Jugador")[0]
	set_physics_process(true)
	procesarRecorrido()
	setearRecorrido()
	sonidoPisadas()
	
func _physics_process(delta):
	var posicionVertical = global_transform.origin.y
	perseguir(delta)
	global_transform.origin.y = posicionVertical
			
func setearRecorrido():
	recorrido = navegacion.get_simple_path(global_transform.origin, puntosLlegada[indice], true)

func procesarRecorrido():
	for objetivos in get_parent().get_node("PuntosPatrulla").get_children():
		puntosLlegada.append(objetivos.global_transform.origin)
		navegacion = get_tree().get_nodes_in_group("Navegacion")[0]

func patrullar(delta):
	if recorrido.size() > 0:
		var d = global_transform.origin.distance_to(recorrido[0])
		if d > 2:
			global_transform.origin = global_transform.origin.linear_interpolate(recorrido[0], (velocidad*delta)/d)
			look_at(recorrido[0], Vector3.UP)
			moviendose = true
		else:
			moviendose = false
			recorrido.remove(0)
	else:
		if indice < puntosLlegada.size()-1:
			indice += 1
		else:
			indice = 0
		setearRecorrido()

func perseguir(delta):
	var dj = global_transform.origin.distance_to(jugador.global_transform.origin)
	if dj < distanciaPerseguidor:
		if jugador.getEscondido() == false:
			global_transform.origin = global_transform.origin.linear_interpolate(jugador.global_transform.origin, (velocidad*delta)/dj)
			look_at(jugador.global_transform.origin, Vector3.UP)
			moviendose = true
		else:
			moviendose = false
			patrullar(delta)
	else:
		patrullar(delta)


func sonidoPisadas():
	if moviendose == true:
		if pisadas.playing == false:
			pisadas.playing = true
	else:
		pisadas.playing = false

func _on_Area_body_entered(body):
	atrapadas = atrapadas + 1
	
	if atrapadas > 3:
		if body.has_method("morir"):
			body.morir()
	
	get_tree().paused == true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if atrapadas == 1 :
		puzzle2C.setPuzzle(true)
		puzzle2C.show()
	if atrapadas == 2:
		puzzle1B.setPuzzle(true)
		puzzle1B.show()
	if atrapadas == 3:
		puzzle1C.setPuzzle(true)
		puzzle1C.show()
	global_transform.origin=(Vector3(36, global_transform.origin.y, 31))
	
#primero da el puzzle
#puzzle si se pone mal se muere, sino vive
#transportar al viejo al patio

