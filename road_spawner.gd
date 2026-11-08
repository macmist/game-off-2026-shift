@tool
extends Node3D

@export_tool_button("Generate Sprites", "Callable")
var generate_action = generate_sprites


@export var size: int = 500
var road: PackedScene = load("res://road.tscn")

		
func generate_sprites():
	# Remove previously generated sprites
	for child in get_children():
		child.free()
		
	
	for i in size:
		var sprite: Road = road.instantiate()
		sprite.position.z = sprite.texture.get_height() * sprite.pixel_size * i
		add_child(sprite)
		sprite.owner = get_tree().edited_scene_root
