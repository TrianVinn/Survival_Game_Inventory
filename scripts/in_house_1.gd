extends Node2D

func _ready() -> void:
	Global.spawn_player($Marker2D.position)
	

func _on_exit_button_down() -> void:
	Global.player.position = Global.enter_position
	Global.remove_player_from_scene()
	Global.looted_buildings[Global.current_building] = true
	get_tree().change_scene_to_file("res://scenes/world.tscn")
