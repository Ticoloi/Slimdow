extends CharacterBody3D


func _ready() -> void:
	$model/AnimationPlayer.connect("animation_finished", _play_idle)
	_play_idle()

func _process(delta: float) -> void:
	pass


func shoot():
	$model/AnimationPlayer.play("shoot")

func _play_idle():
	$model/AnimationPlayer.play("Idle")
