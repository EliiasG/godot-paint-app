extends Node


func _ready() -> void:
	var pallete_image: Image = Image.new()
	pallete_image.load("res://Assets/palette.png")
	pallete_image.lock()
	var pallete_array: Array = Array()
	for y in range(pallete_image.get_height()):
		for x in range(pallete_image.get_width()):
			var pixel: Color = pallete_image.get_pixel(x, y)
			if !pallete_array.has(pixel):
				pallete_array.append(pixel)
				pallete_array.append(pixel)
	State.palette = PoolColorArray(pallete_array)
