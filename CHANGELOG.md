# Changelog

All notable changes to Albedolizer PBR Generator for Godot.

## [1.0.0] — 2026-09-26

### Added
- Initial release
- Editor dock: **Albedolizer** in the right panel
- Generate 7 PBR maps from Albedo textures
- AI color correction (Autolevels, LUTwithBGrid) + Math fallback
- 50 material presets with auto-detect from filename
- Auto-created StandardMaterial3D with proper channels (R=Metallic, G=AO, A=Smoothness)
- Engine packing: Unity URP, Unity HDRP, Unreal, Godot ORM
- CLI bundled — auto-copied to `user://albedolizer/cli/` on plugin enable
- Progress bar — Godot stays responsive during generation
- GitHub / itch.io quick links
- Donate dialog with crypto wallets

### Requirements
- Godot 4.5+
- Windows 10/11 (64-bit)