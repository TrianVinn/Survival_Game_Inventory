extends Node

var player:CharacterBody2D
const PLAYER = preload("res://scenes/player.tscn")
var enter_position = null

var inventory_player:Dictionary = {}

var item_db = {}

var looted_houses = {}

func _ready() -> void:
	player = PLAYER.instantiate()
	loot_all_items()
	
func spawn_player(position):
	player.position = position
	player.target = position
	get_tree().current_scene.add_child(player)
	
func remove_player_from_scene():
	if player and player.get_parent():
		player.get_parent().remove_child(player)
	
func add_item(item:ItemResource,amount:int):
	
	if inventory_player.has(item.item_name):
		inventory_player[item.item_name] += amount
	else:
		inventory_player[item.item_name] = amount
	inventory_updated.emit()
	force_ui_update()
func remove_item(item:ItemResource, amount:int):
	
	if inventory_player.has(item.item_name):
		inventory_player[item.item_name] -= amount
		if inventory_player[item.item_name] <= 0:
			inventory_player.erase(item.item_name)
	inventory_updated.emit()
	force_ui_update()
signal inventory_updated

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
