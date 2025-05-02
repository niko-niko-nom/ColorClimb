extends Resource

class_name Fandom

var name_of_fandom: String

var parody_of_fandom: String

var release_year: int

var reboot_years: Array = []

var base_popularity: float = 1.0
var popularity_decay_rate: float = 0.1
var current_popularity: float = 1.0

func _init(_name: String, _parody_of: String, _release_year: int, _base_popularity: float = 1.0, _decay: float = 0.1, _reboots := []):
	name_of_fandom = _name
	parody_of_fandom = _parody_of
	release_year = _release_year
	base_popularity = _base_popularity
	popularity_decay_rate = _decay
	reboot_years = _reboots
	current_popularity = base_popularity

func update_popularity(current_year: int) -> void:
	var years_since_release = current_year - release_year
	if current_year in reboot_years:
		current_popularity = min(1.0, current_popularity + 0.5)
	else:
		current_popularity = max(0.0, base_popularity - years_since_release * popularity_decay_rate)

func is_available(current_year: int) -> bool:
	if current_year >= release_year:
		return true
	else:
		return false
