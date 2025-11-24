extends RigidBody2D

#Variables del eix y, per la gravetat
const GRAVITY = 80
const JUMP_HEIGHT = 200
var fall_speed = 0
var jump_speed = 0

var double_jump = 1

var FLOOR = 1016
var floor = 616

#Variables del eix X
var RIGHT_LIMIT = 1500 #Limit de dreta perooo general
var right_limit = 900 #Limit de dreta del node

var VELOCITY = 1000

const PLAYER_SIZE = 200
var player_size = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	#Establim Mides

	resize(player_size, player_size)

func resize(eixX, eixY):
	floor = FLOOR - eixY
	get_window().size = Vector2(eixX, eixY)
	right_limit = RIGHT_LIMIT - player_size
	position.x = 0
	position.y = 0
	$player.size.x = get_window().size.x
	$player.size.y = get_window().size.y
	$CollisionShape2D.position.x = get_window().size.x/2
	$CollisionShape2D.position.y = get_window().size.y/2
	$CollisionShape2D.shape.size.x = get_window().size.x
	$CollisionShape2D.shape.size.y = get_window().size.y
	$AnimatedSprite2D.scale.y = get_window().size.y/40 * 2.5
	$AnimatedSprite2D.scale.x = get_window().size.x/40 * 2.5
	$AnimatedSprite2D.position.x = get_window().size.x/2
	$AnimatedSprite2D.position.y = get_window().size.y/2
	
	get_viewport().files_dropped.connect(on_files_dropped)

func on_files_dropped(files):
	pass
	#var file = FileAccess.open(files[0], FileAccess.WRITE)
	#if(file.is_open()):
		#file.store_string("Slime?")
	
	#file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Declarem variables
	var momvement: Vector2
	var ypos = get_window().position.y
	var xpos = get_window().position.x
	
	#Declarem el es pot moure o no boolea
	var CanRight
	var CanLeft
	
	if(xpos > 0):
		CanLeft = 1
	else:
		CanLeft = 0
	
	if(xpos < right_limit):
		CanRight = 1
	else:
		CanRight = 0
	
	#Aqui es declara el moviment per X
	var IRight = Input.get_action_strength("ui_right") * CanRight
	var ILeft = Input.get_action_strength("ui_left")  * CanLeft
	
	if(IRight):
		$AnimatedSprite2D.flip_h = false
		if(ypos >= floor):
			$AnimatedSprite2D.play("Walk")

	elif(ILeft):
		$AnimatedSprite2D.flip_h = true
		if(ypos >= floor):
			$AnimatedSprite2D.play("Walk")

	else:
		$AnimatedSprite2D.play("Idle")
	
	#Aplicar moviment de x
	momvement.x = xpos + ceil(VELOCITY*IRight*delta) - ceil(VELOCITY*ILeft*delta)
	momvement.y = ypos
	get_window().position = momvement
	
	#Quan es toqui a accept, salta
	if(Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") ):
		if(ypos >= floor):
			jump_speed = JUMP_HEIGHT
		else:
			if(double_jump > 0):
				jump_speed = JUMP_HEIGHT
				double_jump = double_jump - 1
				fall_speed = 0
	
	#Si es pot fer, baixem el salt
	if(jump_speed > 0):
		jump_speed = jump_speed - GRAVITY*delta
	
	var gravity = 0
	
	#Si no toca el terra, llavors baixem
	if(ypos < floor):
		pass
		$AnimatedSprite2D.play("Jump")
		fall_speed = fall_speed  + GRAVITY*delta
		gravity = 1/2*delta*delta*GRAVITY
	else:
		double_jump = 1
		fall_speed = 0
	
	#Aplicar moviment Y
	if(Input.is_action_pressed("ui_down")):
		resize(player_size, round(player_size/2))
	else:
		resize(player_size, player_size)
	#Girar eix Y en funció de gravetat i salt
	if(floor(fall_speed*delta + gravity) > round(jump_speed*delta)):
		$AnimatedSprite2D.flip_v = true
	else:
		$AnimatedSprite2D.flip_v = false
	
	#Que fer quan no shift
	if(Input.is_action_just_released("ui_down")):
		if(ypos + PLAYER_SIZE > FLOOR):
			get_window().position.y = FLOOR - player_size
	elif(Input.is_action_just_pressed("ui_down")):
		get_window().position.y = ypos + player_size/2
	else:
		get_window().position.y = ypos +  floor(fall_speed*delta + gravity) - round(jump_speed*delta)
	#Sortir get_window().files_dropped.connect(_o_n_files_dropped())del programa
	
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
