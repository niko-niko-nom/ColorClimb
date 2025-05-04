extends Node

var tag_data := SkillLoader.new()

var population = Population

var max_energy = 100
var energy = 100
var min_energy = 0

var money = 0

var max_happiness = 100
var happiness = 100
var min_happiness = 0

var max_creativity = 100
var creativity = 100
var min_creativity = 0

var current_year = 2012

var max_life_left = 80
var life_left = 80
var min_life_left = 0

var max_anxiety = 100
var anxiety = 0
var min_anxiety = 0

var max_burnout = 100
var burnout = 0
var min_burnout = 0

var max_follower_count = 1 #change this to the sum of all potential followers later
var follower_count = 0
var min_follower_count = 0

var max_reputation = 100
var reputation = 50
var min_reputation = 0

var player_fandoms = []

var player_art_style = {}

var unlocked_tags = {}

var player_art_specializations = {
	"fanart": 0,
	"originals": 0,
	"corporate": 0,
	"generative_ai": 0,
}

var player_skills = {
	"digital_art": 0,
	"traditional_art": 0,
	"pixel_art": 0,
	"3d_modelling": 0,
	"animation": 0,
	"prompting": 0,
}

func gain_skill(tag: String, amount: int):
	player_skills[tag] = player_skills.get(tag, 0) + amount
	_check_unlocks()

func _check_unlocks():
	for tag_name in tag_data.TAGS:
		var tag_info = tag_data.TAGS[tag_name]
		if tag_info.has("requires") and not unlocked_tags.get(tag_name, false):
			var requirements_met = true
			for required_tag in tag_info.requires:
				var needed = tag_info.requires[required_tag]
				if player_skills.get(required_tag, 0) < needed:
					requirements_met = false
					break
			if requirements_met:
				unlocked_tags[tag_name] = true
				print("Unlocked tag: ", tag_name)

func get_specializations() -> Dictionary:
	return player_art_specializations

func get_skills() -> Dictionary:
	return player_skills

func get_unlocked_specializations() -> Array:
	var unlocked = []
	for spec in player_art_specializations:
		if player_art_specializations[spec] > 0:
			unlocked.append(spec)
	return unlocked

func get_unlocked_fandoms() -> Array:
	return player_fandoms.duplicate()

func get_unlocked_artstyles() -> Array:
	var unlocked = []
	for style in player_art_style:
		if player_art_style[style] > 0:
			unlocked.append(style)
	return unlocked

func get_unlocked_mediums() -> Array:
	var unlocked = []
	for medium in player_skills:
		if player_skills[medium] > 0:
			unlocked.append(medium)
	return unlocked

func get_unlocked_tags() -> Array:
	return unlocked_tags.keys()
