extends Node

var available_fandoms = []
var possible_interests = []
var possible_type = ["Lurker", "Liker", "Commenter", "Commissioner", "Patron", "Super Fan"]


func _ready() -> void:
	call_deferred("_initialize")

func _initialize() -> void:
	if PlayerStats.player_art_specializations != null:
		possible_interests.append_array(PlayerStats.player_art_specializations.values())
	if PlayerStats.player_skills != null:
		possible_interests.append_array(PlayerStats.player_skills.values())
	if PlayerStats.player_mediums != null:
		possible_interests.append_array(PlayerStats.player_mediums.values())
	
	var fandoms = update_available_fandoms(PlayerStats.current_year)
	if fandoms != null:
		available_fandoms.append_array(fandoms)

func update_available_fandoms(current_year: int) -> Array:
	var fandoms = []
	
	available_fandoms.clear()
	for fandom in FandomData.all_fandoms:
		if fandom.is_available(current_year):
			fandom.update_popularity(current_year)
			fandoms.append(fandom)
	
	return fandoms
