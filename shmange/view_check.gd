extends CheckButton

var value = false

func _on_toggled(toggled_on: bool) -> void:
	value = toggled_on

func _process(delta: float) -> void:
	if !value:
		icon = load("res://Images/UI/TopView.png")
	else:
		icon = load("res://Images/UI/FirstPerson.png")
