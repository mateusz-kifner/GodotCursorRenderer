extends Node2D

var keyBlue  = preload("res://keyBlue.png")

# This is exapmle scene that renders Cursor with Texture keyBlue and count of 10 attached to it.
# You can use CursorRenderer as singelton.
# CursorRenderer needs custom cursor image to work. (cursor provided is trash)
# by Mateusz Kifner

func _ready():
	yield(get_tree(), "idle_frame") # Wait one frame to ensure that CursorRenderer is loaded
	$CursorRenderer.render_cursor(keyBlue,10) # Render Cursor
