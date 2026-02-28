# Advanced FPS Player Controller (Godot 4)

---

# 🇷🇺 Русская инструкция

## 📦 Установка

1. Создайте `CharacterBody3D`.
2. Прикрепите `Player.gd`.
3. Добавьте внутрь:
   - `Camera3D`
   - (по желанию) один UI элемент:
	 - `TextureProgressBar`
	 - `ProgressBar`
	 - `VSlider`
4. Назначьте их в инспекторе.

---

## 🎥 Камера

### Camera
- `mouse_sensitivity`
- `fov`

### Rotation
- `invert_x`
- `invert_y`
- `min_pitch`
- `max_pitch`

Инверсия по умолчанию отключена.

---

## 🏃 Движение

### Movement
- `walk_speed`
- `sprint_speed`
- `jump_force`
- `gravity`

---

## ⚡ Система выносливости

### General
- `stamina_enabled` — включает/выключает систему
- `max_stamina`
- `stamina_drain_speed`
- `stamina_recover_speed`

### Stamina UI
- `stamina_ui_type` — выбор:
  - TextureProgressBar
  - ProgressBar
  - VSlider
- Назначьте соответствующий UI элемент

---

## Поведение

- UI скрывается при полной энергии
- Бег отключается при 0
- Восстанавливается автоматически
- Если `stamina_enabled = false`, система полностью отключается

---

## 🎮 Input Map

Добавьте в Project Settings → Input Map:

- move_forward
- move_back
- move_left
- move_right
- sprint
- jump

---

---

# 🇬🇧 English Instruction

## 📦 Installation

1. Create a `CharacterBody3D`.
2. Attach `Player.gd`.
3. Add:
   - `Camera3D`
   - (optional) one of:
	 - TextureProgressBar
	 - ProgressBar
	 - VSlider
4. Assign them in inspector.

---

## 🎥 Camera

### Camera
- mouse_sensitivity
- fov

### Rotation
- invert_x
- invert_y
- min_pitch
- max_pitch

Inversion disabled by default.

---

## 🏃 Movement

### Movement
- walk_speed
- sprint_speed
- jump_force
- gravity

---

## ⚡ Stamina System

### General
- stamina_enabled
- max_stamina
- stamina_drain_speed
- stamina_recover_speed

### Stamina UI
- stamina_ui_type
- Assign correct UI node

---

## Behaviour

- UI hides when full
- Sprint disabled at zero stamina
- Auto recovery
- Fully disabled if stamina_enabled = false

---

## 🎮 Input Map

Add:

- move_forward
- move_back
- move_left
- move_right
- sprint
- jump
