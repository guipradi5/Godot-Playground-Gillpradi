extends CanvasLayer
class_name UI

signal pause(state)
signal dialogueWindowOpened(state)
@onready var textWindow = %"Text Window"
@onready var scoreLabel = %Score
@onready var dialogueNameLabel = %DialogueName
@onready var dialogueLabel = %Dialogue

@onready var pauseMenu = %PauseMenu

var closeTextWindowOnNextInteraction = true
#TODO This should be in the interaction component
@export var timeForNextInteraction = 0.25
@export var timerForNextInteraction = 0.25

var score = 0:
	set(newScore):
		score = newScore
		_updateScoreLabel()
		
var dialogueName = '':
	set(newName):
		dialogueName = newName
		_updateDialogueNameLabel()
		
var dialogue = '':
	set(newDialogue):
		dialogue = newDialogue
		_updateDialogueLabel()

func _ready():
	_updateScoreLabel()
	pauseMenu.hide()
	

func _process(delta):
	if timerForNextInteraction > 0:
		timerForNextInteraction -= delta
	
	if Input.is_action_just_pressed("pause"):
		if pauseMenu.is_visible_in_tree():
			pauseMenu.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			emit_signal("pause", false)
			get_tree().paused = false
		else:
			get_tree().paused = true
			pauseMenu.show()
			emit_signal("pause", true)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _sumScore(newScore):
	score += newScore

func _updateScoreLabel():
	scoreLabel.text = str(score)

func showTextWindow():
	timerForNextInteraction = timeForNextInteraction
	emit_signal("dialogueWindowOpened", true)
	textWindow.show()

func hideTextWindow():
	timerForNextInteraction = timeForNextInteraction
	emit_signal("dialogueWindowOpened", false)
	textWindow.hide()

func toggleTextWindow():
	if textWindow.is_visible_in_tree():
		hideTextWindow()
	else:
		showTextWindow()

func _updateDialogueNameLabel():
	dialogueNameLabel.text = str(dialogueName)
	
func _updateDialogueLabel():
	dialogueLabel.text = str(dialogue)

func _updateTextWindow(newName, newDialogue):
	dialogueName = newName
	dialogue = newDialogue
	if not textWindow.is_visible_in_tree():
		showTextWindow()


func _exitGame():
	get_tree().quit()
