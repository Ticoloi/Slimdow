extends CharacterBody3D

@export var SPEED: float = 10

const DIRECTION: Vector3 = Vector3(0,0,1)

@export var direction: Vector3 = Vector3(0,0,1)



func _ready() -> void:
	rotate(Vector3(0,1,0),Vector2(direction.x, direction.z).angle_to(Vector2(DIRECTION.x, DIRECTION.z)))
	rotate(Vector3(-1,0,0), Vector2(direction.y, direction.z).angle_to(Vector2(DIRECTION.y, DIRECTION.z)))
func _process(delta: float) -> void:
	position = position + SPEED*direction*delta
