extends EditorExportPlugin

var colored_folders: Dictionary[String, String] = {}
var always_export_data := []

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
	colored_folders.assign(ProjectSettings.get("file_customization/folder_colors"))
	always_export_script = ProjectSettings.get("addons/exclude_colored_folders/always_export_data_script", "")
	if always_export_script != "":
		always_export_data = load(always_export_script).new().data


func _export_file(path: String, type: String, features: PackedStringArray) -> void:
	if path in always_export_data:
		return
	var base_dir = path.get_base_dir()
	for colored_folder in colored_folders:
		if base_dir.begins_with(colored_folder) or (base_dir + "/").begins_with(colored_folder):
			var color = colored_folders[colored_folder]
			match ProjectSettings.get_setting("addons/exclude_colored_folders/folder_color_operation/%s" % color, ExcludeColoredFolders.FolderColorOperation.NO_OPERATION):
				ExcludeColoredFolders.FolderColorOperation.DO_NOT_EXPORT_ALWAYS:
					skip_file(path, color)
					return
				ExcludeColoredFolders.FolderColorOperation.DO_NOT_EXPORT_ON_RELEASE:
					if not OS.is_debug_build():
						skip_file(path, color)
						return
				ExcludeColoredFolders.FolderColorOperation.DO_NOT_EXPORT_ON_DEBUG:
					if OS.is_debug_build():
						skip_file(path, color)
						return


func skip_file(path: String, color: String) -> void:
	print("Skip export for %s, since it's in folder %s with color %s" % [path, path.get_base_dir(), color])
	skip()
