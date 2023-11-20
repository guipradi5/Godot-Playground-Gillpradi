extends Node

signal saySomething(npmName, dialogue, dialoguesSize)
signal doSomething()
signal dialogueEnded()
@export var npcName:String = ""
@export var dialogues:Array[String] = []
@export var lastDialogueId = 0
@export var doSomethingAfterDialogue = false:
	set(value):
		doSomethingAfterDialogue = value

func _sayDialogue(any = {}):
	if lastDialogueId < dialogues.size():
		emit_signal("saySomething", npcName, dialogues[lastDialogueId])
		lastDialogueId += 1
	else:
		emit_signal("dialogueEnded")
		lastDialogueId = 0
		if doSomethingAfterDialogue:
			_doSomething({})

func _doSomething(any = {}):
	emit_signal("doSomething")

func _sayAndDoSomething(any = {}):
	_sayDialogue({})
	_doSomething({})
