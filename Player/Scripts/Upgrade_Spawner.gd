extends Node2D

var upgrade_prefab = preload("res://Player/Prefabs/upgrades_parent.tscn")

func level_up():
	var upgrades = upgrade_prefab.instantiate()
	upgrades.position = owner.position
	owner.add_sibling(upgrades)
