extends Node2D

@export var items: Array[InventoryItem] = []
@export var area: Area2D

func _ready():
	area.area_entered.connect(_on_pickup)
	
func _on_pickup(area):
	var component = area.get_parent().get_node("InventoryComponent")
	var inventory = component if component else Inventory.get_inventory()
	if inventory:
		var rand = randi_range(0, len(items)-1)
		var item = items[rand]
		(inventory as InventoryComponent).add_item(item)
		UI.create_texture_tween(global_position, item.icon)
		# destroy box
		queue_free()
