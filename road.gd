class_name Road
extends Sprite3D



func get_size():
	var texture_size := texture.get_size()
	var size_3d := texture.get_size() * pixel_size
	return size_3d
