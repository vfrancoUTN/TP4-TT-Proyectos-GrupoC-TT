extends KinematicBody

var gravedad = Vector3.DOWN * 24
var velocidad = 4
var velocidadSalto = 15
var giro = 0.1
var direccion = Vector3()
var salto = false

func _physics_process(delta):
	direccion += gravedad * delta
	get_input()
	direccion = move_and_slide(direccion, Vector3.UP)
	if salto and is_on_floor():
		direccion.y = velocidadSalto
	
func get_input():
	var vy = direccion.y
	direccion = Vector3()
	if Input.is_action_pressed("Adelante"):
		direccion += -transform.basis.z * velocidad
	if Input.is_action_pressed("Atras"):
		direccion += transform.basis.z * velocidad / 2
	if Input.is_action_pressed("Derecha"):
		direccion += transform.basis.x * velocidad
	if Input.is_action_pressed("Izquierda"):
		direccion += -transform.basis.x * velocidad
	direccion.y = vy
	salto = false
	if Input.is_action_just_pressed("Saltar"):
		salto = true

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-lerp(0, giro, event.relative.x/20))
