extends Control

func _ready():
	PlayerStats.check_for_unlocks()
	ActivitiesData.load_activities()
	if PlayerStats.first_startup:
		GlobalConfigFile.start_new_game()
		PlayerStats.first_startup = false
