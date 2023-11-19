extends Sprite2D

signal changeScore(value)

func showMessage():
	print("HELLO!")

func updateScore():
	emit_signal("changeScore", 100)

func _on_interactable_interacted(any = {}):
	updateScore()
