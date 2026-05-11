extends Control

@onready var grid = $CanvasLayer/Panel/GridContainer
@onready var wood_item = preload("res://inventory/items/wood.tres")
var slot_scene = preload("res://scenes/slot_inventory.tscn")


func _ready() -> void:
	update_display()
func update_display():
	for child in grid.get_children():
		child.queue_free()
	
	var slot = slot_scene.instantiate()
	slot.setup(wood_item, 5)
	grid.add_child(slot)
