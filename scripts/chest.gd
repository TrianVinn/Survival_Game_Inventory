extends Area2D

@export var loot_item:ItemResource
@export var amount:int
@export var loot_item2:ItemResource
@export var amount2:int

var is_looted = false


func _on_body_entered(body: Node2D) -> void:
	if !is_looted:
		Global.add_item(loot_item, amount)
		if loot_item2:
			Global.add_item(loot_item2,amount2)
		print(Global.inventory_player)
		is_looted = true
		
		
