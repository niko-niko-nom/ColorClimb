extends Node2D

var line = Line2D.new()

func draw_paths():
	var nodes = get_tree().get_nodes_in_group("SkillButtons")
	for node in nodes:
		print(node.connect_skills)
		for dependant in node.connect_skills:
			var start_point = node.position + node.size / 2
			var end_point = dependant.position + dependant.size / 2
			line.add_point(start_point, 0)
			line.add_point(end_point, 1)
			line.joint_mode = Line2D.LINE_JOINT_ROUND
			line.width = 2
			add_child(line)
