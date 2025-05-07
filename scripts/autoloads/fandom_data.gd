extends Node

class_name FandomLoader

const FANDOM_JSON_PATH := "res://ColorClimb/data/fandoms.json"

var all_fandoms: Dictionary = {}

var available_fandoms: Dictionary = {}

func _ready():
	load_fandoms()

func load_fandoms():
	var file = FileAccess.open(FANDOM_JSON_PATH, FileAccess.READ)
	if not file:
		push_error("Could not open fandoms.json")
		return
	
	var json_text = file.get_as_text()
	var data = JSON.parse_string(json_text)
	
	if typeof(data) != TYPE_ARRAY:
		push_error("Expected top‑level Array, got %s" % typeof(data))
		return
	
	for entry in data:
		if entry.has("name"):
			all_fandoms[entry.name] = entry
		else:
			push_warning("Entry missing 'name' field: %s" % str(entry))
			
	return all_fandoms

func find_available_fandoms():
	for fandom in all_fandoms:
		var current_year = PlayerStats.current_year
		var release_year = all_fandoms[fandom].get("release_year", 2020)
		
		if current_year >= release_year:
			available_fandoms[fandom] = fandom
