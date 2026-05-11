extends Panel

@onready var icon = $TextureRect
@onready var label = $Label

	
func setup(item:ItemResource, amount:int):
	icon.texture = item.icon
	label.text = str(amount)
	
