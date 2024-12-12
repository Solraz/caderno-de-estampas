extends PlayerInputs
class_name Player

@onready var myShape = $CollisionShape3D
@onready var mySkin = $MeshInstance3D
@onready var bonker = $Headbonk
@onready var spring = $TwistPivot/PitchPivot
@onready var coyoteTimer = $CoyoteTime
@onready var view = $TwistPivot/PitchPivot/view
@onready var dialogue_control = $TwistPivot/PitchPivot/view/DialogueViewport/CanvasLayer/DialogueControl

var height = 1.8 # the model is 2 meter tall

signal new_dialogue
signal show_dialogue
signal close_dialogue

func _ready():
	mySkin.set_sorting_offset(1)
	camera = get_node(stats.camPath)
	stats.on_floor = false
	
func _process(delta):
	view.fov = clamp(70 + sqrt(stats.vel.length() * 7), 90, 120)
	# spring.spring_length = clamp(4 + (sqrt(stats.vel.length()) / 1.5), 8, 100)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		InputKeys()
		ViewAngles(delta)
	
	stats.snap = -get_floor_normal()
	stats.wasOnFloor = stats.on_floor

	velocity = stats.vel
	move_and_slide_own()
	stats.vel = velocity
	
	if stats.wasOnFloor && !stats.on_floor:
		coyoteTimer.start()
	
	if (stats.on_floor):
		stats.shouldJump = true
	else:
		if coyoteTimer.is_stopped():
			stats.shouldJump = false
			pass

func clearCoyote():
	coyoteTimer.stop()
	stats.shouldJump = false
	stats.on_floor = false

func CheckVelocity():
	if (stats.vel.length() > stats.ply_maxvelocity):
		stats.vel = stats.ply_maxvelocity
	elif (stats.vel.length() < -stats.ply_maxvelocity):
		stats.vel = -stats.ply_maxvelocity

func move_and_slide_own() -> bool:
	var collided := false
	stats.on_floor = false

	var checkMotion := velocity * (1 / 60.)
	checkMotion.y -= stats.ply_gravity * (1 / 360.)
		
	var testcol := move_and_collide(checkMotion, true)

	if testcol:
		var testNormal = testcol.get_normal()
		if testNormal.angle_to(up_direction) < stats.ply_maxslopeangle:
			stats.on_floor = true

	var motion := velocity * get_delta_time()

	for step in max_slides:
		var collision := move_and_collide(motion)
		
		if not collision:
			break
	
		var normal = collision.get_normal()
		
		motion = collision.get_remainder().slide(normal)
		velocity = velocity.slide(normal)

		collided = true

	return collided
	
func get_delta_time() -> float:
	if Engine.is_in_physics_frame():
		return get_physics_process_delta_time()

	return get_process_delta_time()

func _on_new_dialogue():
	stats.curr_diag = stats.dialogue[0]
	stats.curr_diag_page = 0
	
	dialogue_control.dialogue_box.bbcode = stats.curr_diag
	dialogue_control.dialogue_page.text = "%s/%s" % [stats.curr_diag_page + 1, stats.dialogue.size()]

func _on_close_dialogue():
	dialogue_control.get_parent().get_parent().visible = false
	dialogue_control.visible = false

func _on_show_dialogue():
	dialogue_control.get_parent().get_parent().visible = true
	dialogue_control.visible = true
