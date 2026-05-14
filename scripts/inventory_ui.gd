extends CanvasLayer

# Ссылки на узлы
@onready var item_grid = $Panel/ItemGrid
@onready var close_button = $CloseButton

# Загружаем сцену ячейки
var slot_scene = preload("res://scenes/inventory_slot.tscn")

# Список всех созданных слотов
var slots = []

# --- При открытии — подписываемся на сигнал инвентаря
func _ready():
	Global.inventory_updated.connect(update_inventory)
	$inventory_panel/items_panel/bag_panel/close_button.pressed.connect(_on_close_pressed)
	update_inventory()

# --- Закрываем окно
func _on_close_pressed():
	visible = false

# --- Создаём слоты, если их не хватает
func ensure_slots(needed):
	while slots.size() < needed:
		var slot = slot_scene.instantiate()
		slot.set_empty()
		$inventory_panel/items_panel/bag_panel/item_grid.add_child(slot)
		slots.append(slot)

# --- Обновляем весь инвентарь
func update_inventory():
	var items = Global.inventory_player
	var needed = max(1, items.size())
	ensure_slots(needed)
	
	var index = 0
	for item_name in items:
		var amount = items[item_name]
		var item = Global.item_db.get(item_name)
		if item:
			slots[index].setup(item, amount)
		index += 1
	
	while index < slots.size():
		slots[index].set_empty()
		index += 1
