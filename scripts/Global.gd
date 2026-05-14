extends Node

var player:CharacterBody2D
const PLAYER = preload("res://scenes/player.tscn")
var enter_position = null

var inventory_player:Dictionary = {}

# База всех предметов (загружается из папки)
var item_db = {}

var looted_houses = {}

var looted_buildings = {}
var current_building = ""

# --- При старте загружаем все предметы из папки
func _ready() -> void:
	player = PLAYER.instantiate()
	loot_all_items()
	
func spawn_player(position):
	player = PLAYER.instantiate()
	player.position = position
	player.target = position
	get_tree().current_scene.add_child(player)
	
func remove_player_from_scene():
	if player and player.get_parent():
		player.get_parent().remove_child(player)

func clear_player():
	if player and is_instance_valid(player):
		player.queue_free()
		player = null

# --- Добавить предмет по названию
func add_item_by_name(item_name: String, amount: int):
	var item = item_db.get(item_name)
	if item:
		add_item(item, amount)
		
# --- Добавить предмет (по ресурсу)
func add_item(item:ItemResource,amount:int):
	var name = item.item_name
	if inventory_player.has(name):
		inventory_player[name] += amount
	else:
		inventory_player[name] = amount
	inventory_updated.emit()
	
	#if inventory_player.has(item.item_name):
		#inventory_player[item.item_name] += amount
	#else:
		#inventory_player[item.item_name] = amount
	#inventory_updated.emit()
	#force_ui_update()
func remove_item(item:ItemResource, amount:int):
	var name = item.item_name
	if inventory_player.has(name):
		inventory_player[name] -= amount
		if inventory_player[name] <= 0:
			inventory_player.erase(name)
	inventory_updated.emit()
	#force_ui_update()
	
# Сигнал, когда инвентарь меняется
signal inventory_updated

# --- Загружаем все .tres из папки items
func loot_all_items():
	var dir_path = "res://inventory/items/"
	var files = DirAccess.get_files_at(dir_path)
	for file in files:
		if file.ends_with(".tres"):
			var item = load(dir_path + file)
			item_db[item.item_name] = item
	
func force_ui_update():
	if has_node("/root/Ui"):
		get_node("/root/Ui").update_display()
	else:
		print("UI не найден")
