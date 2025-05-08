extends TextureButton

@onready var panel: Panel = $Panel
@onready var margin_container: MarginContainer = $MarginContainer
@onready var label: Label = $MarginContainer/Label

@export var skill_button_name: String = "Placeholder Name"
@export var connect_skills: Array[Node] = []

var is_activated : bool
var is_unlocked : bool

func _ready() -> void:
	self.name = skill_button_name
	self.add_to_group("SkillButtons")
	label.text = skill_button_name
	is_activated = false
	is_unlocked = false
	panel.visible = true
	if PlayerStats.first_startup:
		first_startup()

func first_startup() -> void:
	var key_name = skill_button_name
	for value in SkillsData.skills_dict.values():
		if key_name != value["name"]:
			continue
		
		is_unlocked = check_if_unlocked(value["name"])
		if is_unlocked:
			is_activated = bool(value["activated"])
			if is_activated and is_unlocked:
				panel.visible = false
				PlayerStats.player_skills[value["name"]] = value
				print("Activated: ", value["name"])
		else:
			disabled = true
			mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
			panel.visible = true
			

func _on_pressed() -> void:
	if is_unlocked:
		if is_activated:
			is_activated = false
			panel.visible = true
			PlayerStats.active_skills.erase(skill_button_name)
			#print(PlayerStats.active_skills)
		else:
			is_activated = true
			panel.visible = false
			PlayerStats.active_skills.append(skill_button_name)
			#print(PlayerStats.active_skills)

func check_if_unlocked(value) -> bool:
	if value in PlayerStats.player_skills:
		return true
	return false
