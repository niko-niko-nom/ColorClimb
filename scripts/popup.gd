extends PopupPanel

var tags = TagData
var stats = PlayerStats
var task_data = {}

@onready var tag_list_container = self

func set_task(data: Dictionary):
	task_data = data

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

func _ready() -> void:
	for tag in task_data.get("available_tags", []):
		if stats.unlocked_tags.get(tag, false) and is_tag_relevant(tag, task_data):
			var checkbox = CheckBox.new()
			checkbox.text = tag.capitalize()
			tag_list_container.add_child(checkbox)
