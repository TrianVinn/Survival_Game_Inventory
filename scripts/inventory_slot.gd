extends TextureButton


# Получаем ссылки на дочерние узлы
@onready var icon = $CenterContainer/TextureRect
@onready var amount_label = $Label

# Данные
var item_ref = null      # какой предмет лежит в ячейке
var current_amount = 0   # сколько штук

# Лимит в одной ячейке
const MAX_STACK = 100


#func _ready():
	#reset()

# --- Заполняем ячейку предметом и количеством
func setup(item, amount):
	item_ref = item
	current_amount = min(amount, MAX_STACK)  # не больше лимита
	icon.texture = item.icon
	amount_label.text = str(current_amount)

# --- Делаем ячейку пустой
func set_empty():
	reset()

func reset():
	item_ref = null
	current_amount = 0
	if icon:                     # проверяем, что иконка существует
		icon.texture = null
	if amount_label:
		amount_label.text = ""
	
# --- Обновляем текст количества (если нужно)
func update_label():
	amount_label.text = str(current_amount)
