extends Area2D

@export var loot_item:ItemResource
@export var amount:int

var is_looted = false


func _on_body_entered(body: Node2D) -> void:
	if !is_looted:
		Global.add_item(loot_item, amount)
		print(Global.inventory_player)
		is_looted = true
		
		
