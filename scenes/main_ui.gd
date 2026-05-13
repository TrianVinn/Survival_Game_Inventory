extends CanvasLayer

var inventory_scene = preload("res://scenes/inventory_ui.tscn")
var inventory_instance = null

func _on_inventory_button_pressed():
	if inventory_instance == null:
		inventory_instance = inventory_scene.instantiate()
		add_child(inventory_instance)
	else:
		inventory_instance.visible = true

func _close_inventory():
	if inventory_instance:
		inventory_instance.visible = false
