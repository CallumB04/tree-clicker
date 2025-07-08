extends Control

func _ready() -> void:
	$TreeClicker.connect("pressed", _on_tree_clicked)
	
func _on_tree_clicked():
	print("tree clicked")
