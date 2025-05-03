extends PopupPanel

@onready var tag_list_container = self

var tags = TagData
var stats = PlayerStats
var task_data: Dictionary = {}

func set_task(data: Dictionary):
	task_data = data
	show_for_task(task_data)

func show_for_task(task: Dictionary) -> void:
	# Clear old checkboxes
	for child in tag_list_container.get_children():
		child.queue_free()

	for tag in task.get("available_tags", []):
		if stats.unlocked_tags.get(tag, false) and is_tag_relevant(tag, task):
			var checkbox = CheckBox.new()
			checkbox.text = tag.capitalize()
			tag_list_container.add_child(checkbox)

func is_tag_relevant(tag: String, task: Dictionary) -> bool:
	var tag_info = tags.tags_dict.get(tag, null)
	if tag_info == null:
		return true
	
	if not tag_info.has("relevant_for"):
		return true
	
	var filters = tag_info["relevant_for"]
	
	if filters.has("mediums") and task.has("medium"):
		if task["medium"] in filters["mediums"]:
			return true
	
	if filters.has("specializations") and task.has("specialization"):
		if task["specialization"] in filters["specializations"]:
			return true
	
	return false
