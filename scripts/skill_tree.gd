extends Control

@onready var path_drawer: Node2D = $PathDrawer

var missing_buttons: Array = []

func _ready() -> void:
	path_drawer.draw_paths()
	skill_button_check()

func skill_button_check():
	var skill_data = SkillsData.skills_dict.keys()
	var node_paths = get_tree().get_nodes_in_group("SkillButtons")
	var button_names = []
	
	for node in node_paths:
		button_names.append(node.name)
	
	for skill in skill_data:
		if skill not in button_names:
			missing_buttons.append(skill)
	
	print("The following skills are missing a button: ", missing_buttons)
