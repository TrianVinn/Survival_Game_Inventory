extends Area2D

@export var loot_item:ItemResource
@export var amount:int



func _on_body_entered(body: Node2D) -> void:
	Global.add_item(loot_item, amount)
	print(Global.inventory_player)
