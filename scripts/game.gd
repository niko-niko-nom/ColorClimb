extends Control

@onready var camera_2d: Camera2D = $Camera2D


func _ready():
	ActivitiesData.load_activities()
	
	if PlayerStats.first_startup:
		GlobalConfigFile.start_new_game()
		PlayerStats.set_startup_stats()
		PlayerStats.startup_fandoms()
		PlayerStats.first_startup = false
	
	PlayerStats.check_for_unlocks()

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_right"):
		camera_2d.move_right()
	elif Input.is_action_just_released("ui_left"):
		camera_2d.move_left()
	elif Input.is_action_just_released("ui_home"):
		camera_2d.move_home()
