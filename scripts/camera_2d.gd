extends Camera2D

var default_position

func _ready() -> void:
	default_position = Vector2(240, 160)
	position = default_position
	print("Camera position set to: ", default_position)

func move_home():
	position = default_position
	print("Home!")

func move_left():
	position -= Vector2( 480 + 10, 0)
	print("To the left, to the left!")

func move_right():
	position += Vector2(480 + 10, 0)
	print("No, you are all right!")
