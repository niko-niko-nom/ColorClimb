extends Control

@onready var money_container = $HBoxContainer/Money
@onready var year_container = $HBoxContainer/Year
@onready var followers_container = $HBoxContainer/Followers
@onready var happiness_container = $HBoxContainer/Happiness
@onready var happiness_progress_bar = $HBoxContainer/Happiness/HappinessBar
@onready var creativity_container = $HBoxContainer/Creativity
@onready var creativity_progress_bar = $HBoxContainer/Creativity/CreativityBar
@onready var energy_container = $HBoxContainer/Energy
@onready var energy_progress_bar = $HBoxContainer/Energy/EnergyBar
@onready var anxiety_container = $HBoxContainer/Anxiety
@onready var anxiety_progress_bar = $HBoxContainer/Anxiety/AnxietyBar
@onready var reputation_container = $HBoxContainer/Reputation
@onready var reputation_progress_bar = $HBoxContainer/Reputation/ReputationBar
@onready var save_button: Button = $HBoxContainer/SaveButton

var last_money := -1
var last_year := -1
var last_followers := -1
var last_happiness := -1.0
var last_creativity := -1.0
var last_energy := -1.0
var last_anxiety := -1.0
var last_reputation := 1.0

func _process(_delta: float) -> void:
	if PlayerStats.money != last_money:
		money_container.text = "Money: " + str(PlayerStats.money)
		last_money = PlayerStats.money
	
	if PlayerStats.current_year != last_year:
		year_container.text = "Year: " + str(PlayerStats.current_year)
		last_year = PlayerStats.current_year
	
	if PlayerStats.follower_count != last_followers:
		followers_container.text = "Followers: " + str(PlayerStats.follower_count)
		last_followers = PlayerStats.follower_count
	
	if PlayerStats.happiness != last_happiness:
		happiness_container.text = "Happiness: " + str(snapped(PlayerStats.happiness, 1))
		happiness_progress_bar.value = PlayerStats.happiness
		last_happiness = PlayerStats.happiness
	
	if PlayerStats.creativity != last_creativity:
		creativity_container.text = "Creativity: " + str(PlayerStats.creativity)
		creativity_progress_bar.value = PlayerStats.creativity
		last_creativity = PlayerStats.creativity
	
	if PlayerStats.energy != last_energy:
		energy_container.text = "Energy: " + str(snapped(PlayerStats.energy, 1))
		energy_progress_bar.value = PlayerStats.energy
		last_energy = PlayerStats.energy
	
	if PlayerStats.anxiety != last_anxiety:
		anxiety_container.text = "Anxiety: " + str(PlayerStats.anxiety)
		anxiety_progress_bar.value = PlayerStats.anxiety
		last_anxiety = PlayerStats.anxiety
	
	if PlayerStats.reputation != last_reputation:
		reputation_container.text = "Reputation: " + str(PlayerStats.reputation)
		reputation_progress_bar.value = PlayerStats.reputation
		last_reputation = PlayerStats.reputation

func _on_save_button_pressed() -> void:
	GlobalConfigFile.save_game()
