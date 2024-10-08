class_name Findable_Object
extends StaticBody3D

signal object_consumed(name)

var particles: GPUParticles3D
var timer : float = 0

# New mesh reference
var shader_reference : MeshInstance3D

# Material reference

var mesh_material = preload("res://world/assets/transparency.tres")
# Create a new mesh

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_layer_value(1,false)
	set_collision_layer_value(2,true)
	
	set_collision_mask_value(2,true)
	
	#for child in get_children():
		#if child.get_class() == "MeshInstance3D":
			#shader_reference = child.duplicate()
			#child.add_child(shader_reference)
	#shader_reference.scale = Vector3(1,1,1)
	#shader_reference.set_surface_override_material(0,mesh_material)
	#shader_reference.visible = false
	
	var scene = load("res://world/findable/findable_particles.tscn")
	particles = scene.instantiate()
	
	self.add_child(particles)

func _process(_delta):
	pass
	#if timer <= 0:
		#shader_reference.visible = false
	#else:
		#timer -= delta
		#shader_reference.visible = true

# For now, because the findable objects are in place a not generated we can emit a call to the state game 
# and then change the check list. 
func consume():
	hide_children()
	set_collision_layer_value(2,false)
	particles.emitting = true
	object_consumed.emit(self.name)
	get_tree().create_timer(1.5).connect("timeout",Callable(self,"queue_free"))
	
func hide_children():
	for index in self.get_child_count():
		var children = self.get_child(index)
		if not (children is GPUParticles3D):
			children.hide()
			
#func highlight():
	#timer = 0.05
