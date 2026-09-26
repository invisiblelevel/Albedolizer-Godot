# Albedolizer PBR Generator for Godot

Generate PBR maps from Albedo textures — right inside Godot Editor.

**Free & open-source (MIT).**

---

## 🇬🇧 English

### What it does

The add-on bundles a headless **Albedolizer CLI** — the same engine used in the desktop app. Right from Godot Editor you get:

- **PBR map generation** from a single Albedo texture: Normal, Metallic/Smoothness/AO packed, plus optional Height and Roughness PNGs
- **AI color correction** — Autolevels or LUTwithBGrid
- **Math fallback** — CLAHE + soft-clip (no AI required)
- **50 material presets** with auto-detect from filename
- **Auto-created StandardMaterial3D** with proper channels:
  - Albedo → `albedo_texture`
  - Normal → `normal_texture`
  - Metallic → Red channel of packed map
  - Roughness → Alpha channel of packed map
  - AO → Green channel of packed map
- **Progress bar** — Godot stays responsive during generation
- **Works offline** — no external services

Everything runs locally. The CLI is bundled inside the add-on and is auto-copied to `user://albedolizer/cli/` when the plugin is enabled.

### Installation

1. Copy `addons/albedolizer/` folder into your Godot project root
2. Open **Project → Project Settings → Plugins**
3. Find **Albedolizer** and check **Enable**
4. Done — CLI is bundled, path is auto-set

**Requirements:**
- Godot **4.5+** (tested on 4.7.2)
- Windows 10/11 (64-bit)

### Usage

1. Open the **Albedolizer** dock in the right panel
2. Pick your **Albedo texture**
3. Choose preset, correction mode
4. Select a **MeshInstance3D** in the scene
5. Click **🎨 Generate PBR**

The maps are copied to `res://albedolizer_output/<name>/` and a **StandardMaterial3D** is auto-created and applied to the selected mesh.

### Import settings (one-time per texture set)

After first generation, set import settings for correct display:

- `_normal.png` → Import tab → **Lossless** in **Compress to** → **Normal Map** checkbox **On** → Reimport
- `_MetallicSmoothness.png` → Import tab → **sRGB** → **Off** → Reimport
- `_albedo.*` → leave as default (sRGB On)

Godot remembers these settings in `.import` files — you do this **once**.

### About Albedolizer

This add-on is the Godot bridge for **Albedolizer** — a free desktop tool for 3D artists:

- 🌐 **GitHub**: [github.com/invisiblelevel/Albedolizer](https://github.com/invisiblelevel/Albedolizer)
- 🎮 **itch.io**: [invlvl.itch.io/albedolizer](https://invlvl.itch.io/albedolizer)
- 🅱️ **Blender add-on**: [Albedolizer-Blender](https://github.com/invisiblelevel/Albedolizer-Blender)
- 🎮 **Unity add-on**: [Albedolizer-Unity](https://github.com/invisiblelevel/Albedolizer-Unity)

### License

Add-on code: **MIT**
Bundled CLI binaries: proprietary.

---

## 🇷🇺 Русский

### Что делает

Аддон включает в себя headless **Albedolizer CLI** — тот же движок, что и в десктопном приложении. Прямо из редактора Godot вы получаете:

- **Генерацию PBR-карт** из одной Albedo-текстуры: Normal, Metallic/Smoothness/AO (упакованные), плюс опционально Height и Roughness PNG
- **AI-коррекцию цвета** — Autolevels или LUTwithBGrid
- **Математический fallback** — CLAHE + soft-clip
- **50 пресетов материалов** с автоопределением из имени файла
- **Автосоздание StandardMaterial3D** с правильными каналами:
  - Albedo → `albedo_texture`
  - Normal → `normal_texture`
  - Metallic → красный канал упакованной карты
  - Roughness → альфа-канал упакованной карты
  - AO → зелёный канал упакованной карты
- **Прогресс-бар** — Godot не виснет во время генерации
- **Работает офлайн** — никаких внешних сервисов

Всё работает локально. CLI идёт в комплекте и автоматически копируется в `user://albedolizer/cli/` при включении плагина.

### Установка

1. Скопируй папку `addons/albedolizer/` в корень своего Godot-проекта
2. Открой **Проект → Настройки проекта → Плагины**
3. Найди **Albedolizer** и поставь галочку **Включить**
4. Готово — CLI уже внутри, путь прописан автоматически

**Требования:**
- Godot **4.5+** (тестировано на 4.7.2)
- Windows 10/11 (64-bit)

### Как пользоваться

1. Открой док **Albedolizer** в правой панели
2. Выбери **Albedo-текстуру**
3. Пресет, режим коррекции
4. Выдели **MeshInstance3D** в сцене
5. Жми **🎨 Generate PBR**

Карты копируются в `res://albedolizer_output/<имя>/` и **StandardMaterial3D** создаётся и применяется к выделенному мешу.

### Настройки импорта (один раз на набор текстур)

После первой генерации настрой импорт для правильного отображения:

- `_normal.png` → вкладка **Импорт** → **Lossless** в **Сжать до** → галочка **Normal Map** **Вкл** → Reimport
- `_MetallicSmoothness.png` → вкладка **Импорт** → **sRGB** → **Off** → Reimport
- `_albedo.*` → оставь по умолчанию (sRGB On)

Godot запоминает эти настройки в `.import` файлах — делаешь **один раз**.

### Про Albedolizer

Этот аддон — мост в Godot для **Albedolizer** — бесплатной десктопной утилиты для 3D-художников:

- 🌐 **GitHub**: [github.com/invisiblelevel/Albedolizer](https://github.com/invisiblelevel/Albedolizer)
- 🎮 **itch.io**: [invlvl.itch.io/albedolizer](https://invlvl.itch.io/albedolizer)
- 🅱️ **Blender-аддон**: [Albedolizer-Blender](https://github.com/invisiblelevel/Albedolizer-Blender)
- 🎮 **Unity-аддон**: [Albedolizer-Unity](https://github.com/invisiblelevel/Albedolizer-Unity)

### Лицензия

Код аддона: **MIT**
Встроенные CLI-бинарники: проприетарные.

---

## License / Лицензия

Add-on code: **MIT** · Bundled CLI binaries: proprietary.
Код аддона: **MIT** · Встроенные CLI-бинарники: проприетарные.