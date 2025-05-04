extends Node

@onready var skill_data = SkillsData.load_skills()

var game_seed = ""

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

var player_fandoms = {}

var player_skills = {}

var player_art_specializations = {
	"fanart": 0,
	"originals": 0,
	"corporate": 0,
	"generative_ai": 0,
}

var player_mediums = {}

func _ready() -> void:
	_check_unlocks_on_new_game()

func _check_unlocks_on_new_game():
	for skill in skill_data.values():
		if skill["unlocked"]:
			player_skills[skill] = skill.duplicate()
			print("Skill in skill_data: ", skill)
	print("Player skills: ", player_skills)
