extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#Definim nodes
	
	
	var player = load("res://Nodes/Game/Player/player.tscn").instantiate() #Afagim jugador
	var floor_node = load("res://Nodes/Game/Map/Floor/window.tscn").instantiate() #Afagim terra
	
	get_window().mode = 2 #Començem fent una finestra gran
	await get_tree().create_timer(1).timeout
	
	#Ara obtenim el terra
	var floor = get_window().size.y
	
	get_window().mode = 4
	await get_tree().create_timer(1).timeout
	
	var limit_right = get_window().size.x
	player.RIGHT_LIMIT = limit_right
	floor_node.RIGHT_LIMIT = limit_right
	
	var sub_floor = get_window().size.y #Sub floor, es la altura del terra profunt
	print("subflor = ", sub_floor, " floor = ", floor)
	if(floor == sub_floor):
		#Si tots dos son iguals, ho defineix com a floor-20
		floor = floor - 20
	
	player.FLOOR = floor #Definim tot als nodes
	floor_node.FLOOR = sub_floor - floor #Definim tot als nodes
	
	floor_node.FloorPosition = floor
	
	get_window().mode = 0
	
	#Configurem tot
	get_tree().get_root().set_transparent_background(true) 
	get_window().borderless = true
	get_window().transparent = true
	
	add_child(player)
	add_child(floor_node)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
