extends Control

var trees: int = 0; ## game score
var current_tree_progress: int = 0; ## value 0-100, when 100 plants tree
var tree_click_strength: int = 1; ## tree progress per click
var tree_progress_per_second: int = 0; ## automatic tree progress per second

func _ready() -> void:
	$TreeClicker.connect("pressed", _on_tree_clicked);
	
func _on_tree_clicked():
	## adding progress to tree
	current_tree_progress += tree_click_strength;
	
	## increasing score and resetting tree once complete
	if current_tree_progress >= 100:
		current_tree_progress -= 100;
		trees += 1;
		$ScoreContainer/TreeCount.text = "Trees: %s" % [trees]; ## updating trees score text
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak1.png");
		$TreeClicker.set_position(Vector2(209, 420));
	elif current_tree_progress >= 75:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak4.png");
		$TreeClicker.set_position(Vector2(135, 222));
	elif current_tree_progress >= 50:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak3.png");
		$TreeClicker.set_position(Vector2(185, 348));
	elif current_tree_progress >= 25:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak2.png");
		$TreeClicker.set_position(Vector2(206, 393));
		
	$ScoreContainer/ProgressContainer/TreeProgress.value = current_tree_progress; ## updating tree progress bar
