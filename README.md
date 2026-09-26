# Albedolizer PBR Generator for Godot

Generate production-ready PBR maps from Albedo textures — right inside Godot Editor.

**Free & open-source (MIT).**

---

## 🇬🇧 English

### What it does

- **7 PBR maps** from a single Albedo texture: Height, Normal, AO, Roughness, Metallic, Edge, ORM
- **AI color correction** — Autolevels or LUTwithBGrid
- **Math fallback** — CLAHE + soft-clip (no AI required)
- **50 material presets** with auto-detect from filename
- **Auto-created StandardMaterial3D** with proper channels (R=Metallic, G=AO, A=Smoothness)
- **Engine packing** — Unity URP / HDRP, Unreal, Godot ORM
- **Progress bar** — Godot stays responsive
- **Works offline** — CLI is bundled inside the add-on

### Installation

1. Copy `addons/albedolizer/` folder into your Godot project
2. Open **Project → Project Settings → Plugins**
3. Find **Albedolizer** and check **Enable**
4. Done — CLI is bundled, path is auto-set

**Requirements:**
- Godot **4.5+** (tested on 4.7.2)
- Windows 10/11 (64-bit)

### Usage

1. Open the **Albedolizer** dock in the right panel
2. Pick your **Albedo texture**
3. Choose preset, correction mode, maps
4. Select a **MeshInstance3D** in the scene
5. Click **🎨 Generate PBR**

The maps are copied to `res://albedolizer_output/<name>/` and a **StandardMaterial3D** is auto-created and applied to the selected mesh.

### Import settings (one-time per texture set)

After first generation, set import settings for correct display:

- `_normal.png` → Import tab → **Lossless** in **Compress to** → **Normal Map** checkbox **On** → Reimport
- `_MetallicSmoothness.png` → Import tab → **sRGB** → **Off** → Reimport
- `_albedo.png` → leave as default (sRGB On)

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

- **7 PBR-карт** из одной Albedo-текстуры: Height, Normal, AO, Roughness, Metallic, Edge, ORM
- **AI-коррекция цвета** — Autolevels или LUTwithBGrid
- **Математический fallback** — CLAHE + soft-clip
- **50 пресетов материалов** с автоопределением из имени файла
- **Автосоздание StandardMaterial3D** с правильными каналами (R=Metallic, G=AO, A=Smoothness)
- **Упаковка под движки** — Unity URP / HDRP, Unreal, Godot ORM
- **Прогресс-бар** — Godot не виснет
- **Работает офлайн** — CLI встроен в аддон

### Установка

1. Скопируй папку `addons/albedolizer/` в свой Godot-проект
2. Открой **Проект → Настройки проекта → Плагины**
3. Найди **Albedolizer** и поставь галочку **Включить**
4. Готово — CLI уже внутри, путь прописан автоматически

**Требования:**
- Godot **4.5+** (тестировано на 4.7.2)
- Windows 10/11 (64-bit)

### Как пользоваться

1. Открой док **Albedolizer** в правой панели
2. Выбери **Albedo-текстуру**
3. Пресет, режим коррекции, карты
4. Выдели **MeshInstance3D** в сцене
5. Жми **🎨 Generate PBR**

Карты копируются в `res://albedolizer_output/<имя>/` и **StandardMaterial3D** создаётся и применяется к выделенному мешу.

### Настройки импорта (один раз на набор текстур)

После первой генерации настрой импорт для правильного отображения:

- `_normal.png` → вкладка **Импорт** → **Lossless** в **Сжать до** → галочка **Normal Map** **Вкл** → Reimport
- `_MetallicSmoothness.png` → вкладка **Импорт** → **sRGB** → **Off** → Reimport
- `_albedo.png` → оставь по умолчанию (sRGB On)

Godot запоминает эти настройки в `.import` файлах — делаешь **один раз**.

### Про Albedolizer

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