extends Node2D

var is_looted = false

var house_id = "house_1"

func _ready() -> void:
	if Global.looted_houses.has(house_id):
		$Sprite2D.modulate = Color(0.5, 0.5, 0.5)
		$Area2D.monitoring = false
		$enter.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if Global.looted_houses.has(house_id):
		return
	else:
		if body.is_in_group("player"):
			$enter.visible = true
			Global.enter_position = body.global_position
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$enter.visible = false
		Global.looted_houses[house_id] = true
		
func _on_enter_button_down() -> void:
	Global.remove_player_from_scene()
	get_tree().change_scene_to_file("res://scenes/in_house_1.tscn")
	$enter.visible = false
	
