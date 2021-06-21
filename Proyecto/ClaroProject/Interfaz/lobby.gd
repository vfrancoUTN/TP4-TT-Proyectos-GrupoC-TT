extends Control

onready var lobby = $"."

func _ready():
	Multijugador.connect("conexion_fallida", self, "_conexion_fallida")
	Multijugador.connect("conexion_exitosa", self, "_conexion_ok")
	Multijugador.connect("actualizacion_lista_jugadores", self, "actualizar_sala")
	Multijugador.connect("juego_terminado", self, "_juego_terminado")
	Multijugador.connect("error_juego", self, "_error_juego")
	print(Multijugador.nivel)
	#if OS.has_environment("USERNAME"):
	#	$Conexion/Nombre.text = OS.get_environment("USERNAME")
	#else:
	#	var escritorio = OS.get_system_dir(0).replace("\\", "/").split("/")
	#	$Conexion/Nombre.text = escritorio[escritorio.size() - 2]
		
func _boton_crear_presionado():
	if $Conexion/Nombre.text == "":
		$Conexion/LabelError.text = "Nombre de usuario no válido!"
		return
		
	$Conexion.hide()
	$Jugadores.show()
	$Conexion/LabelError.text = ""
	
	var nombre_jugador = $Conexion/Nombre.text
	Multijugador.crear_servidor(nombre_jugador)
	actualizar_sala()
	
func _boton_unirse_presionado():
	if $Conexion/Nombre.text == "":
		$Conexion/LabelError.text == "Nombre de usuario no válido!"
		return
		
	var ip = $Conexion/IP.text
	if not ip.is_valid_ip_address():
		$Conexion/LabelError.text = "Dirección IP no válida!"
		return
		$Conexion/LabelError.text = ""
		$Conexion/BotonCrear.disabled = true
		$Conexion/BotonUnirse.disabled = true
		
		var nombre_jugador = $Conexion/Nombre.text
		Multijugador.unirse_servidor(ip, nombre_jugador)
		
func _conexion_ok():
	$Conexion.hide()
	$Jugadores.show()
	
func _conexion_fallida():
	$Conexion/BotonCrear.disabled = false
	$Conexion/BotonUnirse.disabled = false
	$Conexion/LabelError.set_text("Conexión fallida.")
	
func _juego_terminado():
	show()
	$Conexion.show()
	$Jugadores.hide()
	$Conexion/BotonCrear.disabled = false
	$Conexion/BotonUnirse.disabled = false
	
func _error_juego(error):
	$AcceptDialog.dialog_text = error
	$AcceptDialog.popup_centered_minsize()
	$Conexion/BotonCrear.disabled = false
	$Conexion/BotonUnirse.disabled = false
	
func actualizar_sala():
	var jugadores = Multijugador.get_lista_jugadores()
	jugadores.sort()
	$Jugadores/ItemList.clear()
	$Jugadores/ItemList.add_item(Multijugador.get_nombre_jugador() + " (Vos)")
	for j in jugadores:
		$Jugadores/ItemList.add_item(j)
		
	$Jugadores/BotonIniciar.disabled = not get_tree().is_network_server()
	
func _boton_iniciar_presionado():
	Multijugador.comenzar_juego()
	hide()
	
func _boton_ip_presionado():
	OS.shell_open("https://icanhazip.com/")
