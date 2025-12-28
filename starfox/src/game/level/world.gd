extends Node3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#$GridMap.set_cell_item(Vector3i(0,1,$SpaceShip.position.z),0,0)
	$Path3D/PathFollow3D.progress = $Path3D/PathFollow3D.progress  + 5*delta
	
