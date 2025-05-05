extends Node

class_name ActivitiesLoader

const ACTIVITIES_JSON_PATH := "res://ColorClimb/data/activities.json"

var activities_dict := {}

func _ready():
	load_activities()

func load_activities():
	var file = FileAccess.open(ACTIVITIES_JSON_PATH, FileAccess.READ)
	if not file:
		push_error("Could not open activities.json")
		return
	
	var json_text = file.get_as_text()
	var data = JSON.parse_string(json_text)
	
	if typeof(data) != TYPE_ARRAY:
		push_error("Expected top‑level Array, got %s" % typeof(data))
		return
	
	for entry in data:
		if entry.has("name"):
			activities_dict[entry.name] = entry
		else:
			push_warning("Entry missing 'name' field: %s" % str(entry))
			
	return activities_dict
	
