extends Node3D

class_name Player

@export var acceleration = .01
@export var speed = 0
@export var max_speed = 20


func _process(delta: float) -> void:
	if Input.is_action_pressed('accelerate') and speed < max_speed:
		speed += acceleration
		if speed > max_speed:
			speed = max_speed
	if Input.is_action_just_pressed('shift'):
		Game.shift.emit()
	position.z += delta * speed

	pass
