extends Resource

class_name TagLoader

const TAG_JSON_PATH := "res://ColorClimb/data/tags.json"

var tags_dict := {}

func _ready():
	load_tags()

func load_tags():
	var file = FileAccess.open(TAG_JSON_PATH, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var result = JSON.parse_string(json_text)
		if result is Array:
			for entry in result:
				if "name" in entry:
					tags_dict[entry["name"]] = entry
				else:
					push_warning("Tag missing 'name' field: %s" % str(entry))
		else:
			push_error("JSON parse error or not an array")
	else:
		push_error("Could not open tags.json")
