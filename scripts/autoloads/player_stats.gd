extends Node

var max_energy = 100
var energy = 0
var min_energy = 0

var money = 0

var max_happiness = 100
var happiness = 0
var min_happiness = 0

var max_creativity = 100
var creativitiy = 0
var min_creativitiy = 0

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

var player_art_style = {
	"Anime": 0,
	"Chibi": 0,
	"Cartoon": 0,
	"Comic Book": 0,
	"Manga": 0,
	"Low-Poly": 0,
	"Vector": 0,
	"Crayoncore": 0,
	"Realism": 0,
	"Hyperrealism": 0,
	"Semi-Realism": 0,
	"Digital Painting": 0,
	"Goth": 0,
	"Dark Fantasy": 0,
	"Grunge": 0,
	"Surreal": 0,
	"Vaporwave": 0,
	"Ukiyo-e": 0,
	"Calligraphy": 0,
	"Furry": 0,
	"Kemono": 0,
	"Pony": 0,
}

var player_art_specializations = {
	"Fanart": 0,
	"Originals": 0,
	"Corporate": 0,
	"Generative AI": 0,
}

var player_skills = {
	"Digital Art": 0,
	"Traditional Art": 0,
	"Pixel Art": 0,
	"3D Modelling": 0,
	"Animation": 0,
	"Prompting": 0,
}
