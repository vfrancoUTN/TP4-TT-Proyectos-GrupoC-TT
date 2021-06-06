extends KinematicBody

onready var camara = $Pivote/Camera
onready var animacionCamara = $Pivote/Camera/AnimationPlayer

var gravedad = -30
export var velocidadMaxima = 5
export var aceleracion = 2
var sensibilidadMouse = 0.002 #medido en radianes por pixel

var velocidad = Vector3()

var escondido = false

func recibirControles():
	var direccionControl = Vector3()
	if Input.is_action_pressed("Adelante"):
		direccionControl += -camara.global_transform.basis.z
	if Input.is_action_pressed("Atras"):
		direccionControl += camara.global_transform.basis.z
	if Input.is_action_pressed("Derecha"):
		direccionControl += camara.global_transform.basis.x
	if Input.is_action_pressed("Izquierda"):
		direccionControl += -camara.global_transform.basis.x
	direccionControl.normalized()
	return direccionControl
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensibilidadMouse)
		$Pivote.rotate_x(-event.relative.y * sensibilidadMouse)
		$Pivote.rotation.x = clamp($Pivote.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	velocidad.y += gravedad * delta
	procesarMovimiento()
	interruptorLinterna()
	animarCamara()
	sonidoPisadas()

func procesarMovimiento():
	var velocidadDeseada = recibirControles() * velocidadMaxima
	
	velocidadDeseada = correr(velocidadDeseada)
	
	velocidad.x = velocidadDeseada.x
	velocidad.z = velocidadDeseada.z
	velocidad = move_and_slide(velocidad, Vector3.UP, true)
	
	
func correr(velocidadDeseada):
	if Input.is_action_pressed("Correr"):
		velocidadDeseada = velocidadDeseada * aceleracion
	else:
		velocidadDeseada = recibirControles() * velocidadMaxima
	return velocidadDeseada

func interruptorLinterna():
	if Input.is_action_just_pressed("Linterna"):
		if $Pivote/Camera/SpotLight.light_energy == 0:
			$Pivote/Camera/SpotLight.light_energy = 1
		else:
			$Pivote/Camera/SpotLight.light_energy = 0
		
	
func animarCamara():
	if velocidad != Vector3():
		animacionCamara.play("MovimientoCabeza")
	else:
		animacionCamara.stop()
		
func sonidoPisadas():
	if velocidad != Vector3():
		if $Sonidos/Pisadas.playing == false:
			$Sonidos/Pisadas.playing = true
	else:
		$Sonidos/Pisadas.playing = false
	
func morir():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().set_input_as_handled()
	get_tree().change_scene("res://Interfaz/PantallaDerrota.tscn")
	
func ganar():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().set_input_as_handled()
	get_tree().change_scene("res://Interfaz/PantallaVictoria.tscn")

func obtenerLlave():
	var llavesActuales = $Inventario.getLlaves()
	var nuevaCantidadLlaves = llavesActuales + 1
	$Inventario.setLlaves(nuevaCantidadLlaves)
	
func perderLlave():
	var llavesActuales = $Inventario.getLlaves()
	var nuevaCantidadLlaves = llavesActuales - 1
	$Inventario.setLlaves(nuevaCantidadLlaves)
	
func chequearLlaves():
	return $Inventario.getLlaves()

func pausa():
	get_tree().change_scene("Menu pausa?") #Esta logica no va a funcionar, un set visible mejor

func activarEscondite():
	escondido = true
	
func desactivarEscondite():
	escondido = false
	
func getEscondido():
	return escondido
	
func activarRespiracion():
	$Sonidos/Respiracion.play()
	
func desactivarRespiracion():
	$Sonidos/Respiracion.stop()
