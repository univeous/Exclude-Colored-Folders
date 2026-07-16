extends EditorExportPlugin

enum FolderColorOperation {
	NO_OPERATION,
	DO_NOT_EXPORT_ALWAYS,
	DO_NOT_EXPORT_ON_RELEASE,
	DO_NOT_EXPORT_ON_DEBUG,
}

var _colored_folders: Dictionary[String, String] = {}
var _is_debug := false


func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
	_colored_folders.assign(ProjectSettings.get("file_customization/folder_colors"))
	_is_debug = is_debug


func _export_file(path: String, type: String, features: PackedStringArray) -> void:
	var base_dir := path.get_base_dir()
	for folder: String in _colored_folders:
		if base_dir == folder or base_dir.begins_with(folder + "/"):
			var color: String = _colored_folders[folder]
			var op: int = ProjectSettings.get_setting(
				"addons/exclude_colored_folders/folder_color_operation/%s" % color,
				FolderColorOperation.NO_OPERATION)
			match op:
				FolderColorOperation.DO_NOT_EXPORT_ALWAYS:
					_skip(path, color)
					return
				FolderColorOperation.DO_NOT_EXPORT_ON_RELEASE:
					if not _is_debug:
						_skip(path, color)
						return
				FolderColorOperation.DO_NOT_EXPORT_ON_DEBUG:
					if _is_debug:
						_skip(path, color)
						return


func _skip(path: String, color: String) -> void:
	print("Skipping export: %s (folder color: %s)" % [path, color])
	skip()
