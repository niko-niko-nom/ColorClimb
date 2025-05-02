extends Resource

var population = Population

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

var player_art_style = {
	"anime": 0,
	"chibi": 0,
	"cartoon": 0,
	"comic Book": 0,
	"manga": 0,
	"low-Poly": 0,
	"vector": 0,
	"crayoncore": 0,
	"realism": 0,
	"hyperrealism": 0,
	"semi-realism": 0,
	"digital painting": 0,
	"goth": 0,
	"dark fantasy": 0,
	"grunge": 0,
	"surreal": 0,
	"vaporwave": 0,
	"ukiyo-e": 0,
	"calligraphy": 0,
	"furry": 0,
	"kemono": 0,
	"pony": 0,
}

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
