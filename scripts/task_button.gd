extends Control

class_name TaskButton

@onready var repeat_button = $HBoxContainer/RepeatCheck
@onready var button = $HBoxContainer/Button
@onready var progress_bar = $HBoxContainer/Button/ProgressBar
@onready var options_button = $HBoxContainer/Options
@onready var options_popup = $Popup

static var active_task : TaskButton = null

@export var task_name: String = "Unnamed Task"
@export var duration: float = 1.0
@export var followers_fluc: int = 0
@export var money_fluc: int = 0
@export var energy_fluc: int = 0
@export var happiness_fluc: int = 0
@export var creativity_fluc: int = 0
@export var life_fluc: int = 0
@export var anxiety_fluc: int = 0
@export var burnout_fluc: int = 0
@export var reputation_fluc: int = 0
@export var specialization: String = ""
@export var fandoms: Array = []
@export var artstyles: Array = []
@export var mediums: Array = []

var progress := 0.0
var is_active := false

func _ready() -> void:
	var data = get_task_data()
	print("Data: ", data)
	print("TaskButton size:", size)
	call_deferred("_deferred_setup")

func _deferred_setup():
	button.pressed.connect(_on_button_pressed.bind())
	_update_ui()

func _update_ui():
	button.text = task_name
	progress_bar.value = 0
	progress = 0
	is_active = false

func get_task_data() -> Dictionary:
	return {
		"name": task_name,
		"duration": duration,
		"followers": followers_fluc,
		"money": money_fluc,
		"energy": energy_fluc,
		"happiness": happiness_fluc,
		"creativity": creativity_fluc,
		"life": life_fluc,
		"anxiety": anxiety_fluc,
		"burnout": burnout_fluc,
		"reputation": reputation_fluc,
		"specialization": specialization,
		"fandoms": fandoms,
		"artstyles": artstyles,
		"mediums": mediums,
	}

func _on_button_pressed() -> void:
	if active_task != self:
		if active_task:
			active_task.pause()
		activate()
	else:
		if is_active:
			pause()
		else:
			activate()

func activate():
	if progress >= 1.0:
		_reset_task()
		
	active_task = self
	is_active = true

func pause():
	is_active = false

func _process(delta: float) -> void:
	if is_active:
		var data = get_task_data()
		if PlayerStats == null:
			print("ERROR: PlayerStats is null!")
			return
		
		var energy_per_second = data.energy / data.duration
		var predicted_energy = PlayerStats.energy + energy_per_second * delta
		
		if predicted_energy < PlayerStats.min_energy:
			print("Not enough energy to continue task.")
			is_active = false
			return
		
		progress += delta / data.duration
		progress = min(progress, 1.0)
		progress_bar.value = progress * 100.0
		
		PlayerStats.energy = predicted_energy
		
		if progress >= 1.0:
			_on_task_complete()


func _on_task_complete():
	is_active = false
	progress_bar.value = 100
	
	apply_task_effects()
	_reset_task()
	
	if repeat_button and repeat_button.button_pressed:
		activate()

func apply_task_effects():
	var data = get_task_data()
	PlayerStats.creativity += data.creativity
	PlayerStats.money += data.money
	PlayerStats.life_left += data.life
	PlayerStats.anxiety += data.anxiety
	PlayerStats.burnout += data.burnout
	PlayerStats.reputation += data.reputation
	
	if data.specialization != "":
		increase_specialization(data.specialization)
	
	if data.artstyles.size() > 0:
		for style in data.artstyles:
			increase_art_style(style)
	
	if data.fandoms.size() > 0:
		for fandom in data.fandoms:
			add_fandom(fandom)
	
	if data.mediums.size() > 0:
		for medium in data.mediums:
			increase_skill(medium)

func _reset_task():
	progress = 0
	progress_bar.value = 0

func _on_options_pressed() -> void:
	var popup = options_popup
	if popup:
		popup.set_task(get_task_data())
		popup.popup_centered()

func increase_specialization(spec_type: String):
	if PlayerStats.player_art_specializations.has(spec_type):
		PlayerStats.player_art_specializations[spec_type] += 1

func increase_art_style(style: String):
	if PlayerStats.player_art_style.has(style):
		PlayerStats.player_art_style[style] += 1

func add_fandom(fandom_name: String):
	if not PlayerStats.player_fandoms.has(fandom_name):
		PlayerStats.player_fandoms.append(fandom_name)

func increase_skill(medium: String):
	if PlayerStats.player_skills.has(medium):
		PlayerStats.player_skills[medium] += 1
