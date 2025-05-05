extends Control

class_name MediumButton

@onready var sprite: TextureRect = $Texture
@onready var progress_bar: ProgressBar = $Texture/ProgressBar
@onready var repeat_check: CheckBox = $RepeatCheck
@onready var placeholder_label: Label = $PlaceholderLabel
@onready var popup_menu: PopupMenu = $PopupMenu
@onready var timer: Timer = $Timer

static var active_task: MediumButton = null

@export var medium_name: String = "Unnamed Medium"
@export var popup_activities: Array = []

var progress := 0.0
var is_active := false
var activity_data: Dictionary = {}
var timer_steps := 0.1
var remaining_time := 0.0

func _ready() -> void:
	repeat_check.set_pressed(false)
	if PlayerStats.first_startup:
		upon_first_startup()
	else:
		populate_popup_menu()
	timer.timeout.connect(_on_timer_timeout)

func upon_first_startup() -> void:
	_update_ui()
	populate_popup_menu()

func _update_ui() -> void:
	placeholder_label.text = medium_name
	progress_bar.value = 0
	progress = 0.0
	is_active = false

func populate_popup_menu() -> void:
	for activity in popup_activities:
		var data = get_activity_data(activity)
		if data and data.get("unlocked"):
			popup_menu.add_item(activity)

func _on_popup_menu_id_pressed(id: int) -> void:
	var clicked = popup_menu.get_item_text(id)
	var data = get_activity_data(clicked)
	if data:
		activity_data = data
		activate()

func get_activity_data(clicked_activity: String) -> Dictionary:
	var key_name = clicked_activity.replacen(" ", "_").to_lower()
	for key in ActivitiesData.activities_dict.keys():
		var data = ActivitiesData.activities_dict[key]
		if data.get("name", "") == key_name:
			return data
	return {}

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var popup_size = popup_menu.size
			popup_menu.position = _clamp_position(get_global_mouse_position(), popup_size)
			popup_menu.visible = true
		
		elif event.button_index == MOUSE_BUTTON_LEFT:
			if active_task != self:
				if not activity_data == {}:
					if is_active:
						pause()
					else:
						activate()
			else:
				if is_active:
					pause()
				else:
					activate()

func _clamp_position(pos: Vector2, size: Vector2) -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 25
	return Vector2(
		clamp(pos.x, margin, screen_size.x - size.x - margin),
		clamp(pos.y, margin, screen_size.y - size.y - margin)
	)

func activate() -> void:
	if not activity_data:
		return
	
	if active_task and active_task != self and active_task.is_active:
		active_task.pause()
	
	active_task = self
	
	if progress >= 1.0:
		reset_activity()
		return
		
	remaining_time = activity_data.get("duration", 0.0)
	is_active = true
	timer.start(timer_steps)

func pause() -> void:
	is_active = false
	timer.stop()

func reset_activity() -> void:
	progress = 0.0
	progress_bar.value = 0
	timer.stop()
	if repeat_check and repeat_check.button_pressed:
		activate()
	else:
		is_active = false
		active_task = null

func _on_timer_timeout() -> void:
	if not is_active:
		return
	var duration = activity_data.get("duration", 1.0)
	var energy_cost = activity_data.get("energy", 0.0)
	var step_energy = energy_cost * (timer_steps / duration)
	if PlayerStats.energy + step_energy < PlayerStats.min_energy:
		print("Not enough energy to continue task.")
		pause()
		return
	PlayerStats.energy += step_energy
	progress += timer_steps / duration
	progress = clamp(progress, 0.0, 1.0)
	progress_bar.value = progress * 100
	if progress >= 1.0:
		pause()
		on_activity_finished()
		reset_activity()

func on_activity_finished() -> void:
	PlayerStats.money += activity_data["money"]
