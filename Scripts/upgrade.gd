extends PanelContainer

signal upgraded_click(amount: float);
signal upgraded_gps(amount: float);

enum upgrade_type {
	CLICK_UPGRADE,
	GPS_UPGRADE
};

## unique upgrade values
@export var upgrade_name: String;
@export var upgrade_description: String;
@export var upgrade_cost: int;
@export var type: upgrade_type;
@export var upgrade_value: float; ## value the upgrade adds (to growth per click/second, etc)

func _ready() -> void:
	## adding unique values to UI
	$MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/UpgradeName.text = upgrade_name;
	$MarginContainer/VBoxContainer2/VBoxContainer/UpgradeDesc.text = upgrade_description;
	$MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer/UpgradeCost.text = str(upgrade_cost);
