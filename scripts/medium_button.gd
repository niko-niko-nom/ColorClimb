extends Control

class_name MediumButton

@onready var sprite: TextureRect = $Texture
@onready var progress_bar: ProgressBar = $Texture/ProgressBar
@onready var repeat_check: CheckBox = $RepeatCheck
@onready var placeholder_label: Label = $PlaceholderLabel

static var active_task : MediumButton = null

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
@export var specializations: Array = []
@export var fandoms: Array = []
@export var artstyles: Array = []
@export var mediums: Array = []

var progress := 0.0
var is_active := false
var task_data: Dictionary = {}

func _ready() -> void:
	await get_tree().process_frame
	var data = get_task_data()
	call_deferred("_deferred_setup")

func _deferred_setup():
	_update_ui()

func _update_ui():
	placeholder_label.text = task_name
	progress_bar.value = 0
	progress = 0
	is_active = false

func get_task_data() -> Dictionary:
	var data = {
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
		"specializations": specializations,
		"fandoms": fandoms,
		"artstyles": artstyles,
		"mediums": mediums,
	}
	
	return data

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
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
	
	if repeat_check and repeat_check.button_pressed:
		activate()

func apply_task_effects():
	var data = get_task_data()
	PlayerStats.creativity += data.creativity
	PlayerStats.money += data.money
	PlayerStats.life_left += data.life
	PlayerStats.anxiety += data.anxiety
	PlayerStats.burnout += data.burnout
	PlayerStats.reputation += data.reputation
	
	if data.fandoms.size() > 0:
		for fandom in data.fandoms:
			add_fandom(fandom)

func _reset_task():
	progress = 0
	progress_bar.value = 0

func add_fandom(fandom_name: String):
	if not PlayerStats.player_fandoms.has(fandom_name):
		PlayerStats.player_fandoms.append(fandom_name)

func get_available_activities():
	pass
