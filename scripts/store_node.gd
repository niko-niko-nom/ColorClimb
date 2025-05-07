extends Control

var stats_calculated: bool = false

enum shop_sizes {Small, Medium, Large, Mega}
@export var size_of_shop: shop_sizes

enum types_of_items {desk_tablet = 1, screen_tablet = 2}
@export_flags("Desk Tablet", "Screen Tablet")
var item_types_in_shop: int = 0
var types_of_items_in_shop_inventory = {}

@export var shop_name: String = "Placeholder Name"
@export var year_established: int = 0
var items_in_shop_inventory: Dictionary = {}

#yearly
var shop_funds_floor: float = 0
var shop_funds_ceiling: float = 0
var shop_funds: float = 0

var fixed_costs_floor: float = 0
var fixed_costs_ceiling: float = 0
var fixed_costs: float = 0

var fixed_income_floor: float = 0
var fixed_income_ceiling: float = 0
var fixed_income: float = 0

#daily chance
var chance_of_discounts_floor: int = 0
var chance_of_discounts_ceiling: int = 0
var chance_of_discounts: int = 0
var sale_happening: bool = false

var discount_depth_floor: int = 0
var discount_depth_ceiling: int = 0
var discount_depth: int = 0

func _ready() -> void:
	if stats_calculated == false:
		set_shop_stats()
		stats_calculated = true
	
	select_types()
	select_items()
	on_day_changed()

func set_shop_stats():
	#print("Type of shop: ", type_of_shop)
	if size_of_shop == 0: #Small shop
		shop_funds_floor = 1000
		shop_funds_ceiling = 5000
		shop_funds = randf_range(shop_funds_floor, shop_funds_ceiling)
		
		fixed_costs_floor = 5000
		fixed_costs_ceiling = 10000
		fixed_costs = randf_range(fixed_costs_floor, fixed_costs_ceiling)
		
		fixed_income_floor = 4000
		fixed_income_ceiling = 15000
		fixed_income = randf_range(fixed_income_floor, fixed_income_ceiling)
		
		chance_of_discounts_floor = 1
		chance_of_discounts_ceiling = 5
		chance_of_discounts = randi_range(chance_of_discounts_floor, chance_of_discounts_ceiling)
		
		discount_depth_floor = 1
		discount_depth_ceiling = 15
	
	elif size_of_shop == 1: #Medium shop
		shop_funds_floor = 3000
		shop_funds_ceiling = 10000
		shop_funds = randf_range(shop_funds_floor, shop_funds_ceiling)
		
		fixed_costs_floor = 10000
		fixed_costs_ceiling = 20000
		fixed_costs = randf_range(fixed_costs_floor, fixed_costs_ceiling)
		
		fixed_income_floor = 12000
		fixed_income_ceiling = 30000
		fixed_income = randf_range(fixed_income_floor, fixed_income_ceiling)
		
		chance_of_discounts_floor = 1
		chance_of_discounts_ceiling = 10
		chance_of_discounts = randi_range(chance_of_discounts_floor, chance_of_discounts_ceiling)
		
		discount_depth_floor = 5
		discount_depth_ceiling = 25
	
	elif size_of_shop == 2: #Large shop
		shop_funds_floor = 5000
		shop_funds_ceiling = 15000
		shop_funds = randf_range(shop_funds_floor, shop_funds_ceiling)
		
		fixed_costs_floor = 20000
		fixed_costs_ceiling = 40000
		fixed_costs = randf_range(fixed_costs_floor, fixed_costs_ceiling)
		
		fixed_income_floor = 25000
		fixed_income_ceiling = 60000
		fixed_income = randf_range(fixed_income_floor, fixed_income_ceiling)
		
		chance_of_discounts_floor = 1
		chance_of_discounts_ceiling = 15
		chance_of_discounts = randi_range(chance_of_discounts_floor, chance_of_discounts_ceiling)
		
		discount_depth_floor = 10
		discount_depth_ceiling = 50
	
	elif size_of_shop == 3: #Mega store
		shop_funds_floor = 50000
		shop_funds_ceiling = 150000
		shop_funds = randf_range(shop_funds_floor, shop_funds_ceiling)
		
		fixed_costs_floor = 150000
		fixed_costs_ceiling = 300000
		fixed_costs = randf_range(fixed_costs_floor, fixed_costs_ceiling)
		
		fixed_income_floor = 200000
		fixed_income_ceiling = 500000
		fixed_income = randf_range(fixed_income_floor, fixed_income_ceiling)
		
		chance_of_discounts_floor = 1
		chance_of_discounts_ceiling = 20
		chance_of_discounts = randi_range(chance_of_discounts_floor, chance_of_discounts_ceiling)
		
		discount_depth_floor = 15
		discount_depth_ceiling = 75
	
	#print("Shop funds: ", shop_funds)
	#print("Fixed costs: ", fixed_costs)
	#print("Fixed income: ", fixed_income)
	#print("Discount chance rolled: ", chance_of_discounts)

func on_day_changed():
	var d20_roll = randi_range(1, 20)
	#print("D20 value rolled: ", d20_roll)
	if d20_roll <= chance_of_discounts:
		sale_happening = true
		print("Sale started!")
		start_sale()
	else:
		if sale_happening:
			sale_happening = false
			print("Sale ended!")
			end_sale()
		
		print("No sale happened today in this store.")

func on_year_changed():
	shop_funds += fixed_income
	shop_funds -= fixed_costs
	print("Shop funds: ", snapped(shop_funds, 0.01))

func on_item_bought(item, money):
	items_in_shop_inventory[item]["amount"] -= 1
	shop_funds += money

func set_shop_funds():
	var years_to_simulate = PlayerStats.current_year - year_established
	while years_to_simulate > 0:
		
		years_to_simulate -= 1

func select_types():
	for type_name in types_of_items.keys():
		var flag = types_of_items[type_name]
		if item_types_in_shop & flag != 0:
			types_of_items_in_shop_inventory[type_name] = type_name
	#print(types_of_items_in_shop_inventory.values())

func select_items():
	for item_name in ItemsData.items_dict.keys():
		var item_data = ItemsData.items_dict[item_name]
		if item_data.type in types_of_items_in_shop_inventory:
			if PlayerStats.current_year >= item_data.release_year:
				items_in_shop_inventory[item_name] = item_data
	#print(items_in_shop_inventory.keys())

func start_sale():
	var keys = items_in_shop_inventory.keys()
	var max_amount_of_discounted_items = keys.size()
	var amount_of_discounted_items = randi_range(1, max_amount_of_discounted_items)
	
	while amount_of_discounted_items > 0:
		var random_index = randi_range(0, keys.size() - 1)
		var random_key = keys[random_index]
		var item = items_in_shop_inventory[random_key]
		
		discount_depth = randi_range(discount_depth_floor, discount_depth_ceiling)
		var discounted_price = item.base_price - (item.base_price * (float(discount_depth) / 100))
		print("Base price of ", item.name, " reduced from ", item.base_price, " to ", discounted_price )
		
		amount_of_discounted_items -= 1

func end_sale():
	pass
