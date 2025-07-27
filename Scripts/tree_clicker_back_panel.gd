extends Panel

signal pressed

func _ready():
	connect("gui_input", _on_gui_input);

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			pressed.emit();
