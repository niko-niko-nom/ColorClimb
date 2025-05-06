extends Node

var game_seed = ""

var first_startup = true

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

var player_art_specializations = {
	"Fanart": 0,
	"Original Work": 0,
	"Corporate Art": 0,
	"Generative AI": 0,
}

var player_mediums = {}

var player_skills = {"Sketching": 12, "Furry": 15,}

#func check_for_unlocks():
	#for key in player_skills:
		#for dict in SkillsData.skills_dict:
			#for requirement in SkillsData.skills_dict[dict]["requires"]:
				#if key in SkillsData.skills_dict[dict]["requires"]:
					#if player_skills[key] >= SkillsData.skills_dict[dict]["requires"][requirement]:
						#if dict not in player_skills:
							#SkillsData.skills_dict[dict]["unlocked"] = true
							#print(dict, " is now unlocked!")
							#player_skills[dict] = 0
					#else:
						#if dict in player_skills:
							#player_skills.erase(dict)
						#SkillsData.skills_dict[dict]["unlocked"] = false
						#print("Not all requirements are met for skill to unlock: ", dict)
						#break
	#print("Checked for unlocks!")
	#print(player_skills)

func check_for_unlocks():
	for skill_name in SkillsData.skills_dict:
		var skill_data = SkillsData.skills_dict[skill_name]
		var requirements = skill_data.get("requires", {})
		var unlocked = true
		
		for entry in requirements:
			var req_skill = entry
			var req_level = requirements[entry]
			if player_skills.get(req_skill, -1) < req_level:
				unlocked = false
				break
		
		if unlocked:
			if skill_name not in player_skills:
				skill_data["unlocked"] = true
				player_skills[skill_name] = 0
				print(skill_name, " is now unlocked!")
		else:
			if skill_name in player_skills:
				player_skills.erase(skill_name)
			skill_data["unlocked"] = false
			print("Not all requirements are met for skill to unlock: ", skill_name)
	
	print("Checked for unlocks!")
	print(player_skills)

func update_fandoms(fandoms, point_amount):
	for fandom in fandoms:
		if fandom in player_fandoms:
			update_fandom_points(fandom, point_amount)
		else:
			player_fandoms[fandom] = 0
			print(fandom, " has been added to player fandoms!")
			check_for_unlocks()

func update_fandom_points(fandom, point_amount):
	player_fandoms[fandom] += point_amount
	print(player_fandoms[fandom])
	check_for_unlocks()

func update_specializations(specializations, point_amount):
	for specialization in specializations:
		if specialization in player_art_specializations:
			update_specialization_points(specialization, point_amount)
		else:
			player_art_specializations[specialization] = 0
			print(specialization, " has been added to player specializations!")
			check_for_unlocks()

func update_specialization_points(specialization, point_amount):
	player_art_specializations[specialization] += point_amount
	print(player_art_specializations[specialization])
	check_for_unlocks()

func update_mediums(mediums, point_amount):
	for medium in mediums:
		if medium in player_mediums:
			update_medium_points(medium, point_amount)
		else:
			player_mediums[medium] = 0
			print(medium, " has been added to player mediums!")
			check_for_unlocks()

func update_medium_points(medium, point_amount):
	player_mediums[medium] += point_amount
	print(player_mediums[medium])
	check_for_unlocks()

func update_skills(skills, point_amount):
	for skill in skills:
		if skill in player_skills:
			update_skill_points(skill, point_amount)
		else:
			player_skills[skill] = skill
			print(skill, " has been added to player skills!")
			check_for_unlocks()

func update_skill_points(skill, point_amount):
	player_skills[skill] += point_amount
	print(player_skills[skill])
	check_for_unlocks()
