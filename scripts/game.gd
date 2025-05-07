extends Control

func _ready():
	ActivitiesData.load_activities()
	
	if PlayerStats.first_startup:
		GlobalConfigFile.start_new_game()
		#PlayerStats.set_startup_stats()
		PlayerStats.startup_fandoms()
		PlayerStats.first_startup = false
	
	PlayerStats.check_for_unlocks()
