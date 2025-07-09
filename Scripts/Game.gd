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
		
	$ScoreContainer/ProgressContainer/TreeProgress.value = current_tree_progress; ## updating tree progress bar
