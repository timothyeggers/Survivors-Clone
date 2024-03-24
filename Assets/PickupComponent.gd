class_name ItemPickupComponent extends Node

@export var item: InventoryItem


func pickup_item(inventory: InventoryComponent):
	(inventory as InventoryComponent).add_item(item)


