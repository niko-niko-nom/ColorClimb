extends Control

class_name TaskButton

@onready var repeat_button = $HBoxContainer/RepeatCheck
@onready var button = $HBoxContainer/Button
@onready var progress_bar = $HBoxContainer/Button/ProgressBar
@onready var options_button = $HBoxContainer/Options
@onready var options_popup = $Popup

static var active_task : TaskButton = null

var task_data = {}
var duration = 0.0
var progress := 0.0
var is_active := false
var pending_task_data = null

func _ready() -> void:
	print("TaskButton size:", size)
	call_deferred("_deferred_setup")

func _deferred_setup():
	button.pressed.connect(_on_button_pressed.bind())
	
	if pending_task_data != null:
		set_task(pending_task_data)

func prepare_task(data: Dictionary):
	pending_task_data = data

func set_task(data: Dictionary):
	task_data = data
	button.text = task_data.name
	duration = task_data.duration
	progress_bar.value = 0
	progress = 0
	is_active = false

func _on_button_pressed() -> void:
	print("button ", button, " was pressed.")
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
		progress += delta / duration
		progress = min(progress, 1.0)
		progress_bar.value = progress * 100.0
		
		if progress >= 1.0:
			_on_task_complete()

func _on_task_complete():
	is_active = false
	progress_bar.value = 100
	print("Finished task:", task_data.name)
	_reset_task()
	
	if repeat_button and repeat_button.button_pressed:
		print("repeating task: ", task_data.name)
		activate()

func _reset_task():
	progress = 0
	progress_bar.value = 0


func _on_options_pressed() -> void:
	options_popup.popup_centered()
