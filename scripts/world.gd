extends Node2D

func _ready() -> void:
	if Global.enter_position == null:
		Global.spawn_player($Marker2D.position)
	if Global.enter_position != null:
		Global.spawn_player(Global.enter_position)
		Global.enter_position = null
