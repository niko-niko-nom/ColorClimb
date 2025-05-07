extends Node

class_name ItemsLoader

const ITEMS_JSON_PATH := "res://ColorClimb/data/items.json"

var items_dict := {}

func _ready():
	load_items()

func load_items():
	var file = FileAccess.open(ITEMS_JSON_PATH, FileAccess.READ)
	if not file:
		push_error("Could not open items.json")
		return
	
	var json_text = file.get_as_text()
	var data = JSON.parse_string(json_text)
	
	if typeof(data) != TYPE_ARRAY:
		push_error("Expected top‑level Array, got %s" % typeof(data))
		return
	
	for entry in data:
		if entry.has("name"):
			items_dict[entry.name] = entry
		else:
			push_warning("Entry missing 'name' field: %s" % str(entry))
	
	return items_dict
