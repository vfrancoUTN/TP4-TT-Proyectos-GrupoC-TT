extends KinematicBody

var velocidad_movimiento = 30
var h_acceleration = 6
var h_velocity = Vector3()
var movimiento = Vector3()
var aceleracion_aire = 1
var aceleracion_normal = 6
var sensibilidad_mouse = 0.1
var direccion_movimiento = Vector3()
var gravedad = 9.8
var altura_salto = 10
var vector_gravedad = Vector3()
var tiene_contacto_piso = false

onready var nodo_cabeza_jugador = $Cabeza
onready var nodo_contacto_piso = $ContactoPiso

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sensibilidad_mouse))
		nodo_cabeza_jugador.rotate_x(deg2rad(-event.relative.y * sensibilidad_mouse))
		nodo_cabeza_jugador.rotation.x = clamp(nodo_cabeza_jugador.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	direccion_movimiento = Vector3()
	
	if nodo_contacto_piso.is_colliding():
		tiene_contacto_piso = true
	else:
		tiene_contacto_piso = false
	
	if not is_on_floor():
		vector_gravedad += Vector3.DOWN * gravedad * delta
		h_acceleration = aceleracion_aire
	elif is_on_floor() and tiene_contacto_piso:
		vector_gravedad = -get_floor_normal() * gravedad
		h_acceleration = aceleracion_normal
	else:
		vector_gravedad = -get_floor_normal()
		h_acceleration = aceleracion_normal
	
	if Input.is_action_pressed("movimiento_adelante"):
		direccion_movimiento -= transform.basis.z
	elif Input.is_action_pressed("movimiento_atras"):
		direccion_movimiento += transform.basis.z
	if Input.is_action_pressed("movimiento_izquierda"):
		direccion_movimiento -= transform.basis.x
	elif Input.is_action_pressed("movimiento_derecha"):
		direccion_movimiento += transform.basis.x
	if Input.is_action_pressed("saltar") and (is_on_floor() or nodo_contacto_piso.is_colliding()):
		vector_gravedad = Vector3.UP * altura_salto
		
	direccion_movimiento = direccion_movimiento.normalized()
	h_velocity = h_velocity.linear_interpolate(direccion_movimiento * velocidad_movimiento, h_acceleration * delta)
	movimiento.z = h_velocity.z + vector_gravedad.z
	movimiento.x = h_velocity.x + vector_gravedad.x
	movimiento.y = vector_gravedad.y
	move_and_slide(movimiento, Vector3.UP)
