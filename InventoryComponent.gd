class_name InventoryComponent extends Node

@export var debug_starting_items = {}
var _items: Dictionary = {}

func _ready():
	for item in debug_starting_items:
		_items[item] = 0

func add_item(item: InventoryItem):
	_items[item.name] = item
	
func get_item(name):
	return _items.get(name)
