@tool
extends EditorPlugin

var import_plugin

func _enter_tree():
	# Initialization of the plugin goes here.
	import_plugin = preload("import_plugin.gd").new()
	add_import_plugin(import_plugin)
	pass

func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_import_plugin(import_plugin)
	import_plugin = null
