extends CanvasLayer

# Ссылки на узлы
@onready var item_grid = $Panel/ItemGrid
@onready var close_button = $CloseButton
@onready var prev_button = $PrevButton
@onready var next_button = $NextButton
@onready var page_label = $PageLabel

const SLOTS_PER_PAGE = 40
var total_pages = 1
var current_page = 0 

# Загружаем сцену ячейки
var slot_scene = preload("res://scenes/inventory_slot.tscn")

# Список всех созданных слотов
var slots = []
var all_slots = []

# --- При открытии — подписываемся на сигнал инвентаря
func _ready():
	Global.inventory_updated.connect(update_inventory)
	$inventory_panel/items_panel/bag_panel/close_button.pressed.connect(_on_close_pressed)
	update_inventory()
	$inventory_panel/items_panel/bag_panel/page_buttons/previus_page.pressed.connect(_on_previus_page_pressed)
	$inventory_panel/items_panel/bag_panel/page_buttons/next_page.pressed.connect(_on_next_page_pressed)
	ensure_slots(40)
# --- Закрываем окно
func _on_close_pressed():
	visible = false

# --- Обновляем весь инвентарь
func update_inventory():
	var items = Global.inventory_player #Получаем данные инвентаря (словарь)
	var total_items = items.size()
	
	ensure_slots(total_items) # Создаём нужное количество слотов (если не хватает)
	
	#Заполняем слоты данными из инвентаря
	var index = 0
	for item_name in items:
		var amount = items[item_name]
		var item = Global.item_db.get(item_name)
		if item and index < all_slots.size():
			all_slots[index].setup(item, amount)
		index += 1
	
	#Очищаем лишние слоты (если предметов стало меньше)
	while index < all_slots.size():
		all_slots[index].set_empty()
		index += 1
		
	#Обрезаем пустые слоты в конце
	var last_filled_index = -1
	for i in range(all_slots.size()):
		if all_slots[i].item_ref != null:  # если слот не пустой
			last_filled_index = i
	var needed_slots = max(40, last_filled_index + 1)
	while all_slots.size() > needed_slots:
		var slot = all_slots.pop_back()
		slot.queue_free()
		
	#Пересчитываем страницы и обновляем отображение
	total_pages = int(ceil(all_slots.size() / float(SLOTS_PER_PAGE)))
	if total_pages == 0:
		total_pages = 1
	
	#Проверяем, не вышли ли за границы
	if current_page >= total_pages:
		current_page = total_pages - 1
	if current_page < 0:
		current_page = 0
	
	update_page_display()

# --- Создаёт слоты, если их не хватает
func ensure_slots(needed: int):
	var needed_pages = ceil(needed / float(SLOTS_PER_PAGE))
	var total_slots_needed = needed_pages * SLOTS_PER_PAGE
	
	while all_slots.size() < total_slots_needed:
		var slot = slot_scene.instantiate()
		slot.set_empty()
		$inventory_panel/items_panel/bag_panel/item_grid.add_child(slot)
		all_slots.append(slot)
	
# --- Показывает только слоты текущей страницы
func update_page_display():
	if total_pages == 0:
		return
	var start = current_page * SLOTS_PER_PAGE
	var end = min(start + SLOTS_PER_PAGE, all_slots.size())
	for i in range(all_slots.size()):
		var slot = all_slots[i]
		slot.visible = (i >= start and i < end)
	
	# Обновляем текст страницы
	$inventory_panel/items_panel/bag_panel/page_buttons/current_page_panel/current_page.text = str(current_page + 1) + " / " + str(total_pages)
	# Включаем/выключаем кнопки при необходимости
	$inventory_panel/items_panel/bag_panel/page_buttons/previus_page.disabled = (current_page == 0)
	$inventory_panel/items_panel/bag_panel/page_buttons/next_page.disabled = (current_page >= total_pages - 1)

# --- Кнопка "Назад"
func _on_previus_page_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		update_page_display()
	
# --- Кнопка "Вперёд"
func _on_next_page_pressed() -> void:
	if current_page < total_pages - 1:
		current_page += 1
		update_page_display()




	
