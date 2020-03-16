extends Viewport

# You can use CursorRenderer as singelton.
# CursorRenderer needs custom cursor image to work. (cursor provided is trash)
# by Mateusz Kifner

var texRect

func render_cursor(item:Texture,num:int =-1):
	# REQUIRED: Setup invisible TextureRect with ViewportTexture to ensure that viewport is rendered.
	if not(get_tree().get_root().has_node("CursorViewport")):
		texRect = TextureRect.new()
		texRect.name = "CursorViewport"
		texRect.texture = get_texture()
		texRect.rect_scale = Vector2()
		texRect.set_global_position(get_tree().get_root().get_viewport().get_mouse_position())
		get_tree().get_root().add_child(texRect)
	# Make TextureRect with ViewportTexture visible
	get_tree().get_root().get_node("CursorViewport").visible = true
	# Set position to mouse, to ensure it is on screen
	texRect.set_global_position(get_tree().get_root().get_viewport().get_mouse_position())
	set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Setup nodes in Viewport. (for example scene only)
	if num >0:
		$Control/Count.text = "x"+str(num)
	else:
		$Control/Count.text = ""
	$Control/Item.texture = item
	$Control/Count.rect_position = $Control/Item.rect_size - $Control/Count.rect_size

	# Let three frames pass to make sure the screen was captured.
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	# Retrieve the captured image.
	var img = get_texture().get_data()

	# Flip it on the y-axis (because it's flipped).
	img.flip_y()

	# Create a texture for it.
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	Input.set_custom_mouse_cursor(tex)
	
	# Hide TextureRect with ViewportTexture visible
	get_tree().get_root().get_node("CursorViewport").visible = false
	






















