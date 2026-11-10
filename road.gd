@tool
class_name Road
extends Node3D

@export var lane_scene: PackedScene = load("res://lane.tscn")
var num_lanes = 1


func get_height():
	var lane: Sprite3D = $Lanes/Lane
	var size_3d = lane.texture.get_height() * lane.pixel_size
	return size_3d

func add_lane():
	var new_lane = lane_scene.instantiate()
	$Lanes.add_child(new_lane)
	var width = new_lane.texture.get_width() * new_lane.pixel_size
	new_lane.position.x = num_lanes * width
	num_lanes += 1