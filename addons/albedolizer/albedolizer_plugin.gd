@tool
extends EditorPlugin

const CLI_SOURCE_DIR: String = "res://addons/albedolizer/cli/"
const CLI_TARGET_DIR: String = "user://albedolizer/cli/"

var dock: Control

func _enter_tree() -> void:
	_copy_cli_to_user()
	var dock_script: GDScript = load("res://addons/albedolizer/albedolizer_dock.gd")
	dock = dock_script.new()
	dock.name = "Albedolizer"
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)

func _exit_tree() -> void:
	if dock:
		remove_control_from_docks(dock)
		dock.queue_free()

func _copy_cli_to_user() -> void:
	DirAccess.make_dir_recursive_absolute(CLI_TARGET_DIR)

	# ═══ Используем абсолютный путь вместо res:// ═══
	var project_dir: String = ProjectSettings.globalize_path("res://")
	var source_dir: String = project_dir.path_join("addons/albedolizer/cli/")
	var target_dir: String = ProjectSettings.globalize_path(CLI_TARGET_DIR)

	var files: Array[String] = [
		"albedolizer_cli.exe",
		"autolevels.exe",
		"free_xcittiny_wa14.onnx",
		"lutwithbgrid_fivek.onnx",
	]

	for fname: String in files:
		var src: String = source_dir.path_join(fname)
		var dst: String = target_dir.path_join(fname)

		if FileAccess.file_exists(dst):
			continue

		if not FileAccess.file_exists(src):
			push_warning("[Albedolizer] Missing CLI file: " + src)
			continue

		var src_file: FileAccess = FileAccess.open(src, FileAccess.READ)
		if src_file == null:
			push_warning("[Albedolizer] Cannot open: " + src)
			continue
		var data: PackedByteArray = src_file.get_buffer(src_file.get_length())
		src_file.close()

		var dst_file: FileAccess = FileAccess.open(dst, FileAccess.WRITE)
		if dst_file == null:
			push_warning("[Albedolizer] Cannot write: " + dst)
			continue
		dst_file.store_buffer(data)
		dst_file.close()

	print("[Albedolizer] CLI ready at: " + target_dir)