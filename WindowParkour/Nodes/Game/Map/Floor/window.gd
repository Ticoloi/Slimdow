extends Window
var FloorPosition = 0
var FLOOR = 1016
var RIGHT_LIMIT = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func resize():
	size = Vector2(FLOOR, RIGHT_LIMIT)
	position.x = 0
	position.y = FloorPosition
	size.x =  RIGHT_LIMIT
	size.y = FLOOR
	
	$ColorRect.size.x = RIGHT_LIMIT
	$ColorRect.size.y = FLOOR
	$ColorRect.position.x = 0
	$ColorRect.position.y = 0
	
	$StaticBody2D/CollisionShape2D.shape.size.x = RIGHT_LIMIT
	$StaticBody2D/CollisionShape2D.shape.size.y = FLOOR
	$StaticBody2D/CollisionShape2D.position.x = FLOOR/2
	$StaticBody2D/CollisionShape2D.position.y = RIGHT_LIMIT/2
	$StaticBody2D.position.x = 0
	$StaticBody2D.position.y = 0

func _process(delta):
	pass


func _on_files_dropped(files: PackedStringArray) -> void:
	#OS.execute("xdg-open",files,[],true,false)
	#var file = FileAccess.open(files[0],FileAccess.READ)
	var image = Image.new()
	image.load(files[0])
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	if(!image.is_empty()):
		$ColorRect.texture = image_texture
	
