extends Node

func start_new_game():
	ensure_save_folder()
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	PlayerStats.game_seed = int(Time.get_unix_time_from_system()) + rng.randi_range(0, 999999)
	rng.seed = PlayerStats.game_seed
	
	print("New game started with seed: ", PlayerStats.game_seed)

func save_game(manual := true):
	ensure_save_folder()
	
	var game_seed = PlayerStats.game_seed
	var file_name = "save_%s.cfg" % game_seed if manual else "save_%s_auto1.cfg" % game_seed
	var save_path = "user://saves/" + file_name
	
	var config = ConfigFile.new()
	config.set_value("meta", "game_seed", game_seed)
	config.set_value("player", "anxiety", PlayerStats.anxiety)
	
	var err = config.save(save_path)
	if err == OK:
		print("Saved to:", ProjectSettings.globalize_path(save_path))
	else:
		print("Save failed! Error code:", err)

func save_autosave():
	ensure_save_folder()
	
	var game_seed = PlayerStats.game_seed
	var autosave_name_old = "save_%s_auto1.cfg" % game_seed
	var autosave_backup = "save_%s_auto2.cfg" % game_seed
	
	var dir = DirAccess.open("user://saves")
	if dir == null:
		push_error("Could not open save folder!")
		return
		
	if dir.file_exists(autosave_name_old):
		var err = dir.rename(autosave_name_old, autosave_backup)
		if err != OK:
			push_warning("Failed to rotate autosaves: %d" % err)
		
	save_game(false)

func find_existing_save(game_seed: String) -> String:
	ensure_save_folder()
	var dir = DirAccess.open("user://saves")
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if file.begins_with("save_%s" % game_seed) and file.ends_with(".cfg"):
			dir.list_dir_end()
			return "user://saves/" + file
		file = dir.get_next()
	dir.list_dir_end()
	return ""

func ensure_save_folder():
	var dir = DirAccess.open("user://")
	if not dir.dir_exists("saves"):
		dir.make_dir("saves")
