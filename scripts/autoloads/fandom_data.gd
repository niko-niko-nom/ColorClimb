extends Resource

class_name FandomLoader

const FANDOM_JSON_PATH := "res://ColorClimb/data/fandoms.json"

var all_fandoms: Array = []

func _ready():
	load_fandoms()

func load_fandoms():
	var file = FileAccess.open(FANDOM_JSON_PATH, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var result = JSON.parse_string(json_text)
		if result is Array:
			for entry in result:
				var fandom = Fandom.new(
					entry.get("name", "Unknown"),
					entry.get("parody_of", ""),
					entry.get("release_year", 0),
					entry.get("base_popularity", 1.0),
					entry.get("popularity_decay_rate", 0.1),
					entry.get("rebot_years", [])
				)
				all_fandoms.append(fandom)
		else:
			push_error("JSON parse error or not an array")
	else:
		push_error("Could not open fandoms.json")
