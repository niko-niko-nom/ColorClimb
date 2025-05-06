extends Node2D

func draw_paths():
	var nodes = get_tree().get_nodes_in_group("SkillButtons")
	for node in nodes:
		for dependant in node.connect_skills:
			var line = Line2D.new()
			var start_point = node.position + node.size / 2
			var end_point = dependant.position + dependant.size / 2
			line.add_point(start_point, 0)
			line.add_point(end_point, 1)
			line.width = 2
			line.default_color = Color.DARK_ORANGE
			add_child(line)
			print("Drew a line between: ", node, " and ", dependant)
