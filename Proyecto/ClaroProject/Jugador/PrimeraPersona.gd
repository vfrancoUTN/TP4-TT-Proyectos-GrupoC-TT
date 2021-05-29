extends KinematicBody

onready var camara = $Pivote/Camera

var gravedad = -30
var velocidadMaxima = 8
var sensibilidadMouse = 0.002 #medido en radianes por pixel

var velocidad = Vector3()

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
	var velocidadDeseada = recibirControles() * velocidadMaxima
	
	velocidad.x = velocidadDeseada.x
	velocidad.z = velocidadDeseada.z
	velocidad = move_and_slide(velocidad, Vector3.UP, true)
	
	
	
