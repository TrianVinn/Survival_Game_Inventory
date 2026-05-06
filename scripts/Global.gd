extends Node

var player:CharacterBody2D
const PLAYER = preload("res://scenes/player.tscn")
var enter_position = null

var inventory_player:Dictionary = {}

func _ready() -> void:
	player = PLAYER.instantiate()
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
func remove_item(item:ItemResource, amount:int):
	if inventory_player.has(item.item_name):
		inventory_player[item.item_name] -= amount
		if inventory_player[item.item_name] <= 0:
			inventory_player.erase(item.item_name)
		
