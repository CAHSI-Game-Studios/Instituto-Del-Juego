extends Control

@onready var label : Label = $VBoxContainer/MarginContainer/Label

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	label.text = "Total: " + str("%10.2f"%PlayerData.total_time) + "s"
	
	
	var keys: Array = PlayerData.map_of_times.keys()
	keys.sort()
	
	# Create data directory
	DirAccess.make_dir_recursive_absolute("user://data")
	var current_time = Time.get_time_string_from_system()
	current_time = current_time.replace(":","-")
	var file_name = "user://data/" + PlayerData.player_name +"_"+ Time.get_date_string_from_system() + "_" + current_time
	var file = FileAccess.open(file_name, FileAccess.WRITE)
	file.store_line(PlayerData.player_name)
	for key in keys:
		file.store_line(create_new_time_label(key, PlayerData.map_of_times[key]))
	file.close()
	
func _on_play_again_pressed():
		get_tree().change_scene_to_file("res://menus/StartScreen.tscn")
		PlayerData.total_time = 0
		PlayerData.map_of_times = {}

func create_new_time_label(time, text):
	var full_text = text + ": " + str("%10.2f"%time) + "s"
	return full_text
	
