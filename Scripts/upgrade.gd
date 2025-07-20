extends PanelContainer

@export var upgrade_name: String;
@export var upgrade_description: String;
@export var upgrade_cost: int;

func _ready() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/UpgradeName.text = upgrade_name;
	$MarginContainer/VBoxContainer/UpgradeDesc.text = upgrade_description;
	$MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer/UpgradeCost.text = str(upgrade_cost);
