extends BaseLevel

@onready var fps_label: Label = %FPSLabel
@onready var count_label: Label = %ProjectileCount
@onready var grazes_label: Label = %GrazesCount
@onready var hits_label: Label = %HitsCount

@onready var camera: Camera2D = $Camera2D

func _ready():
	super._ready()
	
func _physics_process(delta):
	camera.position -= Vector2(0, 40) * delta

func _process(_delta):
	super._process(_delta)
	var currentFps := Performance.get_monitor(Performance.TIME_FPS)
	fps_label.text = "%d" % currentFps
	count_label.text = "%d" % Global.projectile_count
	grazes_label.text = "%d" % Global.grazes_count
	hits_label.text = "%d" % Global.hits_count
	#grazes_label.text = "%d" % (100.0 * Global.grazes_count / (Global.grazes_count + Global.projectile_count + 1))
	
