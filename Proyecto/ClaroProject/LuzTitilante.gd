extends Spatial

export(NodePath) var luzFuenteNodePath
export var retraso = 0.25
export var iteraciones = 4
export var iniciaEncendida = true
export var titilando = true
export var tiempoSinTitilar = 2.0
var luzFuente
var energiaInicial = 0

var temporizador = 0
var iteracion = 0

func _ready():
	luzFuente = get_node(luzFuenteNodePath)
	energiaInicial = luzFuente.light_energy
	
	if not iniciaEncendida:
		luzFuente.light_energy = 0
		
func _physics_process(delta):
	#while true:
	titilar(delta)
	
func titilar(delta):
	yield(get_tree().create_timer(tiempoSinTitilar), "timeout")
	if titilando:
		temporizador -= 1.0 * delta
		if temporizador <= 0:
			if luzFuente.light_energy > 0:
				luzFuente.light_energy = 0
			else:
				luzFuente.light_energy = energiaInicial
				
			iteracion += 0.5
			temporizador = retraso
			if iteracion >= iteraciones:
				titilando = false
				yield(get_tree().create_timer(tiempoSinTitilar), "timeout")
				iteracion = 0
				titilando = true
	
	
	
