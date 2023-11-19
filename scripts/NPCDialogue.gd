extends Node

signal saySomething(npmName, dialogue)
@export var npcName:String = ""
@export var dialogues:Array = []
@export var lasDialogueId = 0

func _sayDialogue(any = {}):
	emit_signal("saySomething", npcName, dialogues[lasDialogueId])
