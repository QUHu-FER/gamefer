extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var run_sound: AudioStreamPlayer = $run  # Suara untuk lari
@onready var footstep_sound: AudioStreamPlayer = $FootstepSound  # Suara untuk loncat

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false  # Variabel untuk memeriksa apakah karakter sedang lompat

func _physics_process(delta):
	# Animations dan suara langkah untuk lari
	if not is_on_floor():
		# Jika karakter tidak di tanah (melompat)
		sprite_2d.animation = "jumping"
		if not is_jumping:
			footstep_sound.play()  # Mainkan suara loncat hanya saat lompat pertama kali
			is_jumping = true  # Tandai bahwa karakter sedang melompat
	else:
		# Jika karakter di tanah dan bergerak
		if velocity.x != 0:
			sprite_2d.animation = "run"
			if not run_sound.playing:
				run_sound.play()  # Mainkan suara lari saat bergerak ke kiri/kanan
		else:
			sprite_2d.animation = "default"
			if run_sound.playing:
				run_sound.stop()  # Hentikan suara lari saat berhenti bergerak

		# Hentikan suara loncat jika karakter sudah kembali ke tanah
		if footstep_sound.playing:
			footstep_sound.stop()

		is_jumping = false  # Reset status lompat saat kembali ke tanah

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	var isleft = velocity.x < 0
	sprite_2d.flip_h = isleft
