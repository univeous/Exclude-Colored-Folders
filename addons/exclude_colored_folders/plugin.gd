@tool
extends EditorPlugin
class_name ExcludeColoredFolders



var export_plugin := preload("res://addons/exclude_colored_folders/export_plugin.gd").new()
enum FolderColorOperation {
	NO_OPERATION,
	DO_NOT_EXPORT_ALWAYS,
	DO_NOT_EXPORT_ON_RELEASE,
	DO_NOT_EXPORT_ON_DEBUG,
}


func _enter_tree() -> void:
	add_export_plugin(export_plugin)
	var colors = ["red", "orange", "yellow", "green", "teal", "blue", "purple", "pink", "gray"]
	var settings = "addons/exclude_colored_folders/folder_color_operation/"
	for color in colors:
		var setting_name = "%s%s" % [settings, color]
		if not ProjectSettings.has_setting(setting_name):
			ProjectSettings.set_setting(setting_name, FolderColorOperation.NO_OPERATION)
		ProjectSettings.add_property_info({ "name": setting_name, "type": TYPE_INT, "hint": PROPERTY_HINT_ENUM, "hint_string": "no operation, do not export(always), do not export(release), do not export(debug)" })
		ProjectSettings.set_initial_value(setting_name, FolderColorOperation.NO_OPERATION)


func _exit_tree() -> void:
	remove_export_plugin(export_plugin)
