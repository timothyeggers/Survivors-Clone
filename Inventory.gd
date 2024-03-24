extends Node

var _inventory := InventoryComponent.new()

func _ready():
	var axe = InventoryItem.new()
	axe.name = "Throwing Axe"
	var sword = InventoryItem.new()
	sword.name = "Throwing Sword"
	_inventory.add_item(axe)
	_inventory.add_item(sword)

func add_item(item: InventoryItem):
	_inventory.add_item(item)
	
func get_item(name):
	return _inventory.get_item(name)

func get_inventory() -> InventoryComponent:
	return _inventory
