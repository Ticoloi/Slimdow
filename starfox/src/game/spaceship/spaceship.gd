extends CharacterBody3D

#La nau especial
var SPEED: float = 2

#x i y: limits a x i y (limits grans)
#z i w: limits a x i y (limits petits)
@export var limits: Vector4

  
#Velocitat de naus
@export var move: bool = false
@export var VELOCITY : float

#Direccio de la nau
var direction: Vector2 =  Vector2(0,0)

func _process(delta: float) -> void:
	if(OS.get_name() != "Android" and OS.get_name() != "iOS"):
		direction.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	else:
		var new_direction: Vector2
		direction.x = Input.get_accelerometer().x
		if(direction.x > 1):
			direction.x = 1
		elif(direction.x < -1):
			direction.x = -1
		direction.y = Input.get_accelerometer().z
		if(direction.y > 1):
			direction.y = 1
		elif(direction.y < -1):
			direction.y = -1
	
	if(position.x >= limits.x):
		if(direction.x > 0):
			pass
			#direction.x = 0
	elif(position.x <= limits.z):
		if(direction.x < 0):
			pass
			#direction.x = 0
	
	if(position.y >= limits.y):
		if(direction.y > 0):
			pass
			#direction.y = 0
	elif(position.y <= limits.w):
		if(direction.y < 0):
			pass
			#direction.y = 0
	
	if(direction.y < 0):
		if(rotation.x >= - 0.436):
			rotation.x = rotation.x + (direction.y*delta*SPEED)
	elif(direction.y > 0):
		if(rotation.x <= 0.436):
			rotation.x = rotation.x + (direction.y*delta*SPEED)
	else:
		if(rotation.x != 0):
			rotation.x = rotation.x - (rotation.x*delta*SPEED)
	
	if(direction.x < 0):
		if(rotation.z >= - 0.436):
			rotation.z = rotation.z + (direction.x*delta*SPEED)
	elif(direction.x > 0):
		if(rotation.z <= 0.436):
			rotation.z = rotation.z + (direction.x*delta*SPEED)
	else:
		if(rotation.z != 0):
			rotation.z = rotation.z - (rotation.z*delta*SPEED)
	if(move):
		position.z = position.z + VELOCITY*delta
	
	var vector_transformed: Vector3 = get_parent().global_transform.basis * Vector3(direction.x, direction.y, 0)
	
	move_and_collide(vector_transformed*delta*SPEED)
	transform.origin.x = clamp(transform.origin.x, -5, 5)
	transform.origin.y = clamp(transform.origin.y, -3, 2.5)
	#move_and_collide(Vector3(direction.x*cos(global_rotation.y),direction.y*cos(global_rotation.x),0)*delta*SPEED)

#Aqui fem un manage de els inputs
func _input(event: InputEvent) -> void:
	if(event is InputEventScreenTouch):
		shoot()
	elif(event.is_action_pressed("ui_accept")):
		shoot()

# La nau dispara iun laseer
func shoot() -> void:
	
	var laser_load = load("res://src/game/entity/projectiles/laser.tscn")
	var laser = laser_load.instantiate()
	#laser.direction = Vector3(dir  ection.x,direction.y,1)
	#laser.direction = Vector3(0,0,-1*cos(rotation.y))
	var rot: Vector3 = get_parent().global_rotation
	laser.direction = Vector3(sin(rot.y),sin(rot.x),0)
	laser.position = global_position  
	get_parent().world.add_child(laser)
