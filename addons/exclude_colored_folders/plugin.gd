@tool
extends EditorPlugin

const _ExportPlugin = preload("res://addons/exclude_colored_folders/export_plugin.gd")

var _export_plugin: EditorExportPlugin


func _enter_tree() -> void:
	_export_plugin = _ExportPlugin.new()
	add_export_plugin(_export_plugin)

	var colors := ["red", "orange", "yellow", "green", "teal", "blue", "purple", "pink", "gray"]
	var prefix := "addons/exclude_colored_folders/folder_color_operation/"
	var hint := "No Operation,Don't Export (Always),Don't Export (Release),Don't Export (Debug)"
	for color: String in colors:
		var setting := prefix + color
		if not ProjectSettings.has_setting(setting):
			ProjectSettings.set_setting(setting, _ExportPlugin.FolderColorOperation.NO_OPERATION)
		ProjectSettings.set_initial_value(setting, _ExportPlugin.FolderColorOperation.NO_OPERATION)
		ProjectSettings.add_property_info({
			"name": setting,
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": hint,
		})


func _exit_tree() -> void:
	remove_export_plugin(_export_plugin)
	_export_plugin = null
