extends KinematicBody

onready var camara = $Pivote/Camera
onready var animacionCamara = $Pivote/Camera/AnimationPlayer
onready var pivote = $Pivote
onready var linterna = $Pivote/Camera/SpotLight
onready var pisadas = $Sonidos/Pisadas
onready var inventario = $Inventario
onready var respiracion = $Sonidos/Respiracion

var gravedad = -30
export var velocidadMaxima = 5
export var aceleracion = 2
var sensibilidadMouse = 0.002 #medido en radianes por pixel

var velocidad = Vector3()

var escondido = false
var pausa = false

func _ready():
	set_physics_process(true)

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
		pivote.rotate_x(-event.relative.y * sensibilidadMouse)
		pivote.rotation.x = clamp(pivote.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	if pausa == false: 
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
		if linterna.light_energy == 0:
			linterna.light_energy = 1
		else:
			linterna.light_energy = 0
		
	
func animarCamara():
	if velocidad != Vector3():
		animacionCamara.play("MovimientoCabeza")
	else:
		animacionCamara.stop()
		
func sonidoPisadas():
	if velocidad != Vector3():
		if pisadas.playing == false:
			pisadas.playing = true
	else:
		pisadas.playing = false
	
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
	var llavesActuales = inventario.getLlaves()
	var nuevaCantidadLlaves = llavesActuales + 1
	inventario.setLlaves(nuevaCantidadLlaves)
	
func perderLlave():
	var llavesActuales = inventario.getLlaves()
	var nuevaCantidadLlaves = llavesActuales - 1
	inventario.setLlaves(nuevaCantidadLlaves)
	
func chequearLlaves():
	return inventario.getLlaves()

func pausa():
	get_tree().change_scene("Menu pausa?") #Esta logica no va a funcionar, un set visible mejor

func activarEscondite():
	escondido = true
	
func desactivarEscondite():
	escondido = false
	
func getEscondido():
	return escondido
	
func activarRespiracion():
	respiracion.play()
	
func desactivarRespiracion():
	respiracion.stop()
	
func activarPausa():
	if pausa == false:
		pausa = true
	
func desactivarPausa():
	if pausa == true:
		pausa = false
