@tool
extends Node3D

@export_tool_button("Generate Sprites", "Callable")
var generate_action = generate_sprites


@export var size: int = 500
var road_scene: PackedScene = load("res://road.tscn")
@export var camera: Camera3D

		
func generate_sprites():
	# Remove previously generated sprites
	for child in get_children():
		child.free()
		
	
	for i in size:
		var sprite: Road = road_scene.instantiate()
		add_child(sprite)
		sprite.add_to_group("roads")
		sprite.position.z = sprite.get_height() * i
		sprite.owner = get_tree().edited_scene_root

func _ready() -> void:
	print("Spawner rotation: ", rotation_degrees)
	print("Spawner global rotation: ", global_rotation_degrees)
	Game.shift.connect(add_lanes)
	

func add_lanes():
	var visible_road: Array[Road] = []
	var other_road: Array[Road] = []
	for road in get_children():
		if road is Road:
			if camera.is_position_in_frustum(road.global_position):
				visible_road.append(road)
			else:
				other_road.append(road)


	var new_width = 0
	var lane_width = 0
	for i in visible_road.size():
		var road: Road = visible_road[i]
		lane_width = road.get_lane_width()
		if road is Road:
			var tween := create_tween()
			tween.tween_interval(i * 0.05)
			tween.tween_callback(func ():
				road.add_lane(true)
			)


	for road in other_road:
		road.add_lane(false)
		new_width = road.get_total_width()
	var tween2 := create_tween()
	print('new_widtth', new_width)

	tween2.tween_interval(1.0)
	tween2.tween_callback(func():
		move_camera(- new_width / 2 + lane_width / 2))

func move_camera(new_x):
	var tween2 := create_tween()

	tween2.tween_property(
		camera,
		"position:x",
		new_x,
		0.4
	).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

	tween2.set_parallel();
	var new_y = camera.position.y + 1;
	tween2.tween_property(
	 	camera,
	 	"position:y",
	 	new_y,
	 	0.4
	 ).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

			
