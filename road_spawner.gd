@tool
extends Node3D

@export_tool_button("Generate Sprites", "Callable")
var generate_action = generate_sprites


@export var size: int = 500
var road: PackedScene = load("res://road.tscn")
@export var camera: Camera3D

		
func generate_sprites():
	# Remove previously generated sprites
	for child in get_children():
		child.free()
		
	
	for i in size:
		var sprite: Road = road.instantiate()
		add_child(sprite)
		sprite.add_to_group("roads")
		sprite.position.z = sprite.get_height() * i
		sprite.owner = get_tree().edited_scene_root

func _ready() -> void:
	print("Spawner rotation: ", rotation_degrees)
	print("Spawner global rotation: ", global_rotation_degrees)
	add_lanes()
	

func add_lanes():
	for i in get_child_count():
		var croad: Road = get_child(i)
		if croad is Road:
			var tween := create_tween()
			tween.tween_interval(i * 0.05)
			tween.tween_callback(func ():
				croad.add_lane(camera and camera.is_position_in_frustum(croad.global_position)))
			
