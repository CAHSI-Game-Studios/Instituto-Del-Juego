class_name Drawer
extends StaticBody3D

@export var animation : AnimationPlayer

var drawer_state = true

# Set the layers oncne the drawer is ready.
func _ready():
	# Layers
	set_collision_layer_value(1,true)
	set_collision_layer_value(2,true)
	
	# Masks
	set_collision_mask_value(1,true)
	
func drawer_interaction():
	if Input.is_action_just_pressed("l_click") and !animation.is_playing():
		if drawer_state:
			animation.play("Open") 
		else:
			animation.play("Close") 
		drawer_state = !drawer_state
