extends Panel

func setup(item:ItemResource, amount: int):
	$TextureRect.texture = item.icon
	$Label.text = str(amount)
	

	
