extends Control

@onready var grid = $CanvasLayer/Panel/GridContainer
@onready var wood_item = preload("res://inventory/items/wood.tres")
var slot_scene = preload("res://scenes/slot_inventory.tscn")

func _ready() -> void:
	update_display()
	

func update_display():
	print(Global.inventory_player)
	print(Global.item_db)
	for child in grid.get_children():
		child.queue_free()
	for item_name in Global.inventory_player:
		var amount = Global.inventory_player[item_name]
		var item = Global.item_db[item_name]
		if item:
			var slot = slot_scene.instantiate()
			slot.setup(item, amount)
			grid.add_child(slot)
	
