extends Control

func _ready() -> void:
	Global.inventory_updated.connect(_on_inventory_changed)
	
func update_display():
	var container = $CanvasLayer/Panel/VBoxContainer
	for child in container.get_children():
		child.queue_free()
	
	for item_name in Global.inventory_player:
		var label = Label.new()
		label.text = item_name + ": " + str(Global.inventory_player[item_name])
		container.add_child(label)
func _on_inventory_changed():
	update_display()
