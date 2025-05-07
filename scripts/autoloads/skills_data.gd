extends Node

class_name SkillLoader

const SKILLS_JSON_PATH := "res://ColorClimb/data/skills.json"

var skills_dict := {}

func _ready():
	load_skills()

func load_skills():
	var file = FileAccess.open(SKILLS_JSON_PATH, FileAccess.READ)
	if not file:
		push_error("Could not open skills.json")
		return
	
	var json_text = file.get_as_text()
	var data = JSON.parse_string(json_text)
	
	if typeof(data) != TYPE_ARRAY:
		push_error("Expected top‑level Array, got %s" % typeof(data))
		return
	
	for entry in data:
		if entry.has("name"):
			skills_dict[entry.name] = entry
		else:
			push_warning("Entry missing 'name' field: %s" % str(entry))
	
	return skills_dict
