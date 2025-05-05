extends Control

func _ready():
	ActivitiesData.load_activities()
	if PlayerStats.first_startup:
		GlobalConfigFile.start_new_game()
		PlayerStats._check_unlocks_on_new_game()
		PlayerStats.first_startup == false
