extends Control

@onready var path_drawer: Node2D = $PathDrawer

func _ready() -> void:
	path_drawer.draw_paths()
