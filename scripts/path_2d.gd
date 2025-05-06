extends Node2D

func draw_paths():
	for skill_button in get_tree().get_nodes_in_group("SkillButton"):
		for path in skill_button.connected_skills:
			if path != null:
				var target = skill_button.get_node_or_null(path)
				if target:
					var start_pos = skill_button.global_position + skill_button.size / 2
					var end_pos = target.global_position + target.size / 2
					draw_line(start_pos, end_pos, Color.BLUE, 2)
