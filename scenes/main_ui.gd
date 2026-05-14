extends CanvasLayer

var inventory_scene = preload("res://scenes/inventory_ui.tscn")
var inventory_instance = null
@onready var inventory_overlay = $InventoryUI

func _on_inventory_button_pressed():
	inventory_overlay.visible = true

func _close_inventory():
	inventory_overlay.visible = false
