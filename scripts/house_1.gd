extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$enter.visible = true
		Global.enter_position = body.global_position
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$enter.visible = false
		
func _on_enter_button_down() -> void:
	Global.remove_player_from_scene()
	get_tree().change_scene_to_file("res://scenes/in_house_1.tscn")
	
