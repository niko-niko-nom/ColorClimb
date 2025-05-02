extends Resource

var tag_data := TagLoader.new()

var population = Population

var max_energy = 100
var energy = 0
var min_energy = 0

var money = 0

var max_happiness = 100
var happiness = 0
var min_happiness = 0

var max_creativity = 100
var creativity = 0
var min_creativity = 0

var current_year = 2012

var max_life_left = 80
var life_left = 0
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
var reputation = 0
var min_reputation = 0

var player_fandoms = []

var player_art_style = {}

var unlocked_tags = {}

var player_art_specializations = {
	"fanart": 0,
	"originals": 0,
	"corporate": 0,
	"generative AI": 0,
}

var player_skills = {
	"digital art": 0,
	"traditional art": 0,
	"pixel art": 0,
	"3D modelling": 0,
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
