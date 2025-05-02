extends Resource

var available_fandoms = []
var possible_interests = []
var possible_type = ["Lurker", "Liker", "Commenter", "Commissioner", "Patron", "Super Fan"]


func _ready() -> void:
	possible_interests.append_array(PlayerStats.player_art_specializations)
	possible_interests.append_array(PlayerStats.player_art_style)
	possible_interests.append_array(PlayerStats.player_skills)
	available_fandoms.append_array(update_available_fandoms(PlayerStats.current_year))

func update_available_fandoms(current_year: int):
	available_fandoms.clear()
	for fandom in FandomData.all_fandoms:
		if fandom.is_available(current_year):
			fandom.update_popularity(current_year)
			available_fandoms.append(fandom)
