extends Resource

var all_fandoms = []

func _ready():
	all_fandoms.append(Fandom.new("Planet Scouts", "Sailor Moon", 1991, 1.0, 0.1, [1992, 1993, 1994, 1995, 1996, 2014, 2016, 2021, 2023]))
	all_fandoms.append(Fandom.new("Unaltered", "Undertale", 2015, 1.0, 0.1, [2018, 2021]))
	all_fandoms.append(Fandom.new("Unrelated", "Deltarune", 2018, 0.8, 0.2, [2019, 2021, 2025]))
	all_fandoms.append(Fandom.new("Unaltered Blue", "Undertale Yellow", 2023, 0.4, 0.1, []))

#pokemon, btw, harry potter, marvel, star wars, game of thrones, doctor who, star trek, avatar atla, avatar, one direction, supernatural, exo, sherlock, twice, lord of the rings, naturo, twilight, the hobbit, rings of power, dragon ball z, 
