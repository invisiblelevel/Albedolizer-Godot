@tool
extends VBoxContainer

# ═══ Пути ═══
var cli_path: String = ""
var albedo_path: String = ""

# ═══ Настройки ═══
var preset: String = "metal"
var correct_mode: String = "ai"
var ai_model: String = "autolevels"
var use_urp_packing: bool = true

# ═══ UI ═══
var cli_label: Label
var albedo_label: Label
var status_label: Label
var progress_bar: ProgressBar
var ai_model_option: OptionButton

const PRESETS: Array[String] = [
	"metal", "rust", "oxidized_metal", "patina", "brass", "aluminum", "copper",
	"wood", "leaves", "moss", "organic", "grass", "bark",
	"stone", "concrete", "brick", "ground", "asphalt", "marble", "sand",
	"clay", "granite", "stucco", "gemstone", "tile", "gravel", "coal",
	"roof_tiles", "plastic", "rubber", "glass", "ceramic", "painted_metal",
	"carbon", "cardboard", "cotton", "wool", "silk", "denim", "carpet",
	"velvet", "water", "mud", "snow", "ice", "leather", "fur", "skin",
	"scales", "bone"
]

func _ready() -> void:
	custom_minimum_size = Vector2(320, 400)
	add_theme_constant_override("separation", 8)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL

	# ═══ Заголовок ═══
	var title = Label.new()
	title.text = "◐ Albedolizer PBR"
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", Color("#5b8dd9"))
	add_child(title)

	# ═══ CLI ═══
	add_child(HSeparator.new())
	add_child(make_section_label("CLI"))

	cli_path = ProjectSettings.globalize_path("user://albedolizer/cli/albedolizer_cli.exe")

	cli_label = Label.new()
	if FileAccess.file_exists(cli_path):
		cli_label.text = "✅ CLI ready"
		cli_label.add_theme_color_override("font_color", Color("#4caf50"))
	else:
		cli_label.text = "❌ CLI not found"
		cli_label.add_theme_color_override("font_color", Color("#e53935"))
	add_child(cli_label)

	# ═══ Albedo ═══
	add_child(HSeparator.new())
	add_child(make_section_label("Albedo Texture"))

	albedo_label = Label.new()
	albedo_label.text = "(not set)"
	albedo_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	albedo_label.add_theme_color_override("font_color", Color("#9aa0a6"))
	add_child(albedo_label)

	var albedo_btn = Button.new()
	albedo_btn.text = "Browse Albedo..."
	albedo_btn.pressed.connect(_on_pick_albedo)
	add_child(albedo_btn)

	# ═══ Preset ═══
	add_child(HSeparator.new())
	add_child(make_section_label("Preset"))

	var preset_opt = OptionButton.new()
	for i in range(PRESETS.size()):
		preset_opt.add_item(PRESETS[i], i)
	preset_opt.item_selected.connect(func(idx: int) -> void:
		preset = PRESETS[idx]
	)
	add_child(preset_opt)

	# ═══ Correction ═══
	add_child(HSeparator.new())
	add_child(make_section_label("Correction"))

	var correct_opt = OptionButton.new()
	correct_opt.add_item("AI", 0)
	correct_opt.add_item("Math (CLAHE)", 1)
	correct_opt.add_item("None", 2)
	correct_opt.item_selected.connect(func(idx: int) -> void:
		correct_mode = ["ai", "math", "none"][idx]
		ai_model_option.visible = (idx == 0)
	)
	add_child(correct_opt)

	# ═══ AI Model ═══
	ai_model_option = OptionButton.new()
	ai_model_option.add_item("Autolevels", 0)
	ai_model_option.add_item("LUTwithBGrid", 1)
	ai_model_option.item_selected.connect(func(idx: int) -> void:
		ai_model = ["autolevels", "lutwithbgrid"][idx]
	)
	add_child(ai_model_option)

	# ═══ Engine Packing ═══
	add_child(HSeparator.new())
	add_child(make_section_label("Engine Packing"))

	var urp_check = CheckBox.new()
	urp_check.text = "Unity URP (R=Metallic, G=AO, A=Smoothness)"
	urp_check.button_pressed = true
	urp_check.toggled.connect(func(on: bool) -> void:
		use_urp_packing = on
	)
	add_child(urp_check)

	# ═══ Generate ═══
	add_child(HSeparator.new())

	var gen_btn = Button.new()
	gen_btn.text = "🎨 Generate PBR"
	gen_btn.custom_minimum_size = Vector2(0, 40)
	gen_btn.add_theme_color_override("font_color", Color("#ffffff"))
	gen_btn.add_theme_stylebox_override("normal", make_button_style("#4caf50"))
	gen_btn.pressed.connect(_on_generate)
	add_child(gen_btn)

	# ═══ Progress ═══
	progress_bar = ProgressBar.new()
	progress_bar.visible = false
	progress_bar.custom_minimum_size = Vector2(0, 8)
	add_child(progress_bar)

	status_label = Label.new()
	status_label.text = ""
	status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_label.add_theme_color_override("font_color", Color("#9aa0a6"))
	add_child(status_label)

	# ═══ Поддержка / Ссылки ═══
	add_child(HSeparator.new())
	add_child(make_section_label("Links"))

	var link_row = HBoxContainer.new()
	link_row.add_theme_constant_override("separation", 6)

	var github_btn = Button.new()
	github_btn.text = "GitHub"
	github_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	github_btn.pressed.connect(func() -> void:
		OS.shell_open("https://github.com/invisiblelevel/Albedolizer")
	)
	link_row.add_child(github_btn)

	var itch_btn = Button.new()
	itch_btn.text = "itch.io"
	itch_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	itch_btn.pressed.connect(func() -> void:
		OS.shell_open("https://invlvl.itch.io/albedolizer")
	)
	link_row.add_child(itch_btn)

	add_child(link_row)

	# ═══ Donate ═══
	var donate_btn = Button.new()
	donate_btn.text = "💛 Support"
	donate_btn.custom_minimum_size = Vector2(0, 32)
	donate_btn.pressed.connect(_on_show_donate)
	add_child(donate_btn)

# ═══ Вспомогательные ═══

func make_section_label(text: String) -> Label:
	var l = Label.new()
	l.text = text
	l.add_theme_font_size_override("font_size", 12)
	l.add_theme_color_override("font_color", Color("#5f6368"))
	return l

func make_button_style(color: String) -> StyleBoxFlat:
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color(color)
	sb.corner_radius_top_left = 8
	sb.corner_radius_top_right = 8
	sb.corner_radius_bottom_left = 8
	sb.corner_radius_bottom_right = 8
	return sb

# ═══ File Picker ═══

func _on_pick_albedo() -> void:
	var dialog = FileDialog.new()
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.add_filter("*.png, *.jpg, *.jpeg, *.tif, *.tiff, *.bmp", "Images")
	dialog.file_selected.connect(func(path: String) -> void:
		albedo_path = path
		albedo_label.text = path
		_auto_detect_preset(path)
	)
	add_child(dialog)
	dialog.popup_centered(Vector2i(800, 600))
	
func _auto_detect_preset(path: String) -> void:
	var fname: String = path.get_file().get_basename().to_lower()
	for i in range(PRESETS.size()):
		if PRESETS[i] in fname:
			preset = PRESETS[i]
			# Обновляем dropdown
			var preset_opt = _find_preset_option()
			if preset_opt != null:
				preset_opt.selected = i
			return

func _find_preset_option() -> OptionButton:
	# Ищем OptionButton с пресетами среди детей
	for child in get_children():
		if child is OptionButton and child.item_count == PRESETS.size():
			return child
	return null

# ═══ Generate ═══

var _thread: Thread
var _thread_running: bool = false
var _pending_output: Array = []
var _pending_exit_code: int = -1

func _on_generate() -> void:
	if _thread_running:
		return
	if cli_path.is_empty() or not FileAccess.file_exists(cli_path):
		_set_status("❌ CLI not found", "#e53935")
		return
	if albedo_path.is_empty() or not FileAccess.file_exists(albedo_path):
		_set_status("❌ Pick an Albedo texture first", "#e53935")
		return

	var albedo_dir: String = albedo_path.get_base_dir()
	var base_name: String = albedo_path.get_file().get_basename()
	var out_dir: String = albedo_dir.path_join("_pbr")

	var args: PackedStringArray = []
	args.append("-i")
	args.append(albedo_path)
	args.append("-o")
	args.append(out_dir)
	args.append("--preset")
	args.append(preset)
	args.append("--correct")
	args.append(correct_mode)
	if correct_mode == "ai":
		args.append("--ai-model")
		args.append(ai_model)
	args.append("--pbr")
	args.append("--maps")
	args.append("height,normal,ao,roughness,metallic")
	if use_urp_packing:
		args.append("--engine")
		args.append("unity_urp")

	_set_status("⏳ Generating PBR...", "#5b8dd9")
	progress_bar.visible = true
	progress_bar.value = 0

	_pending_output = []
	_pending_exit_code = -1
	_thread_running = true
	_current_base_name = base_name
	_current_out_dir = out_dir

	# ═══ Запуск CLI в потоке ═══
	_thread = Thread.new()
	_thread.start(_run_cli_thread.bind(cli_path, args))

	# ═══ Опрос потока из главного ═══
	_poll_thread()

var _current_base_name: String = ""
var _current_out_dir: String = ""

func _run_cli_thread(cli: String, args: PackedStringArray) -> void:
	var output: Array = []
	var exit_code: int = OS.execute(cli, args, output, true)
	# Возвращаем результат в главный поток
	call_deferred("_on_cli_finished", exit_code, output)

func _on_cli_finished(exit_code: int, output: Array) -> void:
	_pending_exit_code = exit_code
	_pending_output = output

func _poll_thread() -> void:
	if not _thread_running:
		return

	# Искусственный прогресс пока CLI молотит
	if progress_bar.value < 90:
		progress_bar.value += 3

	if _pending_exit_code != -1:
		# CLI закончил
		_thread_running = false
		if _thread.is_started():
			_thread.wait_to_finish()

		progress_bar.value = 100
		progress_bar.visible = false

		if _pending_exit_code != 0:
			var err_text: String = ""
			for line in _pending_output:
				err_text += str(line) + "\n"
			_set_status("❌ CLI failed (exit %d):\n%s" % [_pending_exit_code, err_text], "#e53935")
			return

		# Копируем PNG в проект
		var project_dir: String = ProjectSettings.globalize_path("res://")
		var assets_dir: String = project_dir.path_join("albedolizer_output/" + _current_base_name)
		DirAccess.make_dir_recursive_absolute(assets_dir)

		# ═══ Сначала копируем ИСХОДНЫЙ albedo с оригинальным расширением ═══
		var ext: String = albedo_path.get_extension().to_lower()
		var albedo_dst: String = assets_dir.path_join(_current_base_name + "_albedo." + ext)
		if FileAccess.file_exists(albedo_path):
			DirAccess.copy_absolute(albedo_path, albedo_dst)

		# ═══ Потом сгенерированные карты ═══
		var png_files: Array[String] = [
			_current_base_name + "_normal.png",
			_current_base_name + "_unity_urp_gl_MetallicSmoothness.png",
		]
		for fname: String in png_files:
			var src: String = _current_out_dir.path_join(fname)
			var dst: String = assets_dir.path_join(fname)
			if FileAccess.file_exists(src):
				DirAccess.copy_absolute(src, dst)

		EditorInterface.get_resource_filesystem().scan()

		_set_status("✅ PBR generated: albedolizer_output/" + _current_base_name, "#4caf50")

		# Ждём импорта ресурсов, потом строим материал
		await get_tree().create_timer(1.0).timeout
		_build_material(_current_base_name, "res://albedolizer_output/" + _current_base_name)
		return

	# Ещё работает — вызываем себя снова через 0.15 сек
	get_tree().create_timer(0.15).timeout.connect(_poll_thread)

func _set_status(text: String, color: String) -> void:
	status_label.text = text
	status_label.add_theme_color_override("font_color", Color(color))

func _build_material(base_name: String, res_dir: String) -> void:
	# ═══ Ищем albedo с любым расширением ═══
	var albedo_file: String = ""
	for ext: String in ["png", "jpg", "jpeg", "tif", "tiff", "bmp"]:
		var candidate: String = res_dir.path_join(base_name + "_albedo." + ext)
		if ResourceLoader.exists(candidate):
			albedo_file = candidate
			break
	var normal_file: String = res_dir.path_join(base_name + "_normal.png")
	var packed_file: String = res_dir.path_join(base_name + "_unity_urp_gl_MetallicSmoothness.png")

	var mat := StandardMaterial3D.new()

	if ResourceLoader.exists(albedo_file):
		mat.albedo_texture = load(albedo_file)
	if ResourceLoader.exists(normal_file):
		mat.normal_enabled = true
		mat.normal_texture = load(normal_file)
	if ResourceLoader.exists(packed_file):
		mat.orm_texture = load(packed_file)
		mat.ao_enabled = true
		mat.ao_texture_channel = BaseMaterial3D.TEXTURE_CHANNEL_GREEN
		mat.roughness_texture_channel = BaseMaterial3D.TEXTURE_CHANNEL_ALPHA
		mat.metallic_texture_channel = BaseMaterial3D.TEXTURE_CHANNEL_RED
		mat.metallic = 1.0

	var selected: Array = EditorInterface.get_selection().get_selected_nodes()
	if selected.size() > 0 and selected[0] is MeshInstance3D:
		selected[0].material_override = mat
		_set_status(status_label.text + "\n✅ Material applied to selected mesh", "#4caf50")
	else:
		var mat_path: String = res_dir.path_join(base_name + "_material.tres")
		ResourceSaver.save(mat, mat_path)
		_set_status(status_label.text + "\n💾 Material saved: " + mat_path, "#4caf50")

# ═══ Donate Dialog ═══

func _on_show_donate() -> void:
	var dlg = AcceptDialog.new()
	dlg.title = "Support Albedolizer"
	dlg.dialog_text = "This add-on is free. If it saves your time —\ndrop some smokes for uncle. Thank you!\n\nBTC:\nbc1q2ka70s4vtmrskandqj8l4d6n3kdxyxa7kf3wf7\n\nUSDT (TRC-20):\nTUjY9p6oxKmeCQwNZwMfHqHdXuabaHpgT7\n\nGRAM:\nUQDWumGNNlnITx48WBzyI7Clb5wrpFRlJ3Se7xhfVKY5E2ad"
	dlg.ok_button_text = "Close"
	add_child(dlg)
	dlg.popup_centered(Vector2i(500, 400))