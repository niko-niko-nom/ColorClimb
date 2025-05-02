extends Control

var tasks = [
	{"name": "Sketch", "duration": 2.0, "creativity_cost": 10, "energy_cost": 5, "reward_skill": 3},
	{"name": "Paint", "duration": 4.0, "creativity_cost": 20, "energy_cost": 8, "reward_skill": 6},
	{"name": "Prompt AI", "duration": 0.5, "creativity_cost": 1, "energy_cost": 2, "reward_skill": 1}
]

@onready var task_button_container = $TaskButtonContainer

func _ready():
	for task in tasks:
		var task_button = preload("res://ColorClimb/scenes/task_button.tscn").instantiate()
		task_button.prepare_task(task)
		task_button_container.add_child(task_button)
