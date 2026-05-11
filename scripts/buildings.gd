extends Node2D

@export var building_id: String
@export var building_resource: BuildingResource

@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var enter_button = $enter

func _ready():
	if Global.looted_buildings.has(building_id):
		set_looted_state()
	else:
		sprite.texture = building_resource.normal_texture
		enter_button.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not Global.looted_buildings.has(building_id):
		enter_button.visible = true
		Global.enter_position = body.global_position

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		enter_button.visible = false

func set_looted_state():
	sprite.texture = building_resource.looted_texture
	area.monitoring = false
	enter_button.visible = false

func _on_enter_pressed() -> void:
	Global.clear_player()
	Global.current_building = building_id  
	get_tree().change_scene_to_file("res://scenes/in_house_1.tscn")  
