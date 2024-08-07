extends Node3D

@onready var findable_objects = $ReferenceToFindableObjects
@onready var check_list = $UI/CheckList
@onready var chronometer = $UI/Chronometer

var findables_list:Array = []

func _ready():
	set_up_findable_objects()
	chronometer.activate_timer()
	check_list.checklist_setup(findables_list)

func set_up_findable_objects():
	for child_index in findable_objects.get_child_count():
		findables_list.append(findable_objects.get_child(child_index).name)

# The Findable Object will emit a signal before being consumed. 
func _on_findable_object_consumed(name):
	check_list.check_item(name)
