extends CharacterBody3D

@export_group("Camera")
@export var camera: Camera3D
@export var mouse_sensitivity: float = 0.2
@export var fov: float = 75.0

@export_subgroup("Rotation")
@export var invert_x: bool = false
@export var invert_y: bool = false
@export var min_pitch: float = -90.0
@export var max_pitch: float = 90.0

@export_group("Movement")
@export var walk_speed: float = 5.0
@export var sprint_speed: float = 9.0
@export var jump_force: float = 4.5
@export var gravity: float = 9.8

@export_group("Stamina")

@export_subgroup("General")
@export var stamina_enabled: bool = true
@export var max_stamina: float = 5.0
@export var stamina_drain_speed: float = 1.0
@export var stamina_recover_speed: float = 1.5

@export_subgroup("Stamina UI")
@export_enum("TextureProgressBar", "ProgressBar", "VSlider")
var stamina_ui_type: int = 0
@export var stamina_texture_bar: TextureProgressBar
@export var stamina_progress_bar: ProgressBar
@export var stamina_vslider: VSlider

@export_group("Input")
@export var forward_action: String = "move_forward"
@export var backward_action: String = "move_back"
@export var left_action: String = "move_left"
@export var right_action: String = "move_right"
@export var sprint_action: String = "sprint"
@export var jump_action: String = "jump"

var current_speed: float
var pitch: float = 0.0
var stamina: float
var can_sprint: bool = true

func _ready():
	current_speed = walk_speed
	stamina = max_stamina
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if camera:
		camera.fov = fov
	_setup_stamina_ui()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventMouseMotion:
		var x_dir = -1 if invert_y else 1
		var y_dir = -1 if invert_x else 1
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity * x_dir))
		pitch -= event.relative.y * mouse_sensitivity * y_dir
		pitch = clamp(pitch, min_pitch, max_pitch)
		if camera:
			camera.rotation_degrees.x = pitch

func _physics_process(delta):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Vector3.ZERO

	if Input.is_action_pressed(forward_action):
		input_dir -= transform.basis.z
	if Input.is_action_pressed(backward_action):
		input_dir += transform.basis.z
	if Input.is_action_pressed(left_action):
		input_dir -= transform.basis.x
	if Input.is_action_pressed(right_action):
		input_dir += transform.basis.x

	input_dir = input_dir.normalized()

	var sprinting = Input.is_action_pressed(sprint_action) and stamina > 0 and stamina_enabled

	if sprinting and can_sprint:
		current_speed = sprint_speed
		stamina -= stamina_drain_speed * delta
	else:
		current_speed = walk_speed
		stamina += stamina_recover_speed * delta

	stamina = clamp(stamina, 0, max_stamina)

	if stamina <= 0:
		can_sprint = false
	if stamina >= max_stamina:
		can_sprint = true

	_update_stamina_ui()

	velocity.x = input_dir.x * current_speed
	velocity.z = input_dir.z * current_speed

	if Input.is_action_just_pressed(jump_action) and is_on_floor():
		velocity.y = jump_force

	move_and_slide()

func _setup_stamina_ui():
	if not stamina_enabled:
		_hide_all_bars()
		return

	match stamina_ui_type:
		0:
			if stamina_texture_bar:
				stamina_texture_bar.max_value = max_stamina
				stamina_texture_bar.editable = false
		1:
			if stamina_progress_bar:
				stamina_progress_bar.max_value = max_stamina
		2:
			if stamina_vslider:
				stamina_vslider.max_value = max_stamina
				stamina_vslider.editable = false

func _update_stamina_ui():
	if not stamina_enabled:
		_hide_all_bars()
		return

	var visible = stamina < max_stamina

	match stamina_ui_type:
		0:
			if stamina_texture_bar:
				stamina_texture_bar.value = stamina
				stamina_texture_bar.visible = visible
		1:
			if stamina_progress_bar:
				stamina_progress_bar.value = stamina
				stamina_progress_bar.visible = visible
		2:
			if stamina_vslider:
				stamina_vslider.value = stamina
				stamina_vslider.visible = visible

func _hide_all_bars():
	if stamina_texture_bar:
		stamina_texture_bar.visible = false
	if stamina_progress_bar:
		stamina_progress_bar.visible = false
	if stamina_vslider:
		stamina_vslider.visible = false
