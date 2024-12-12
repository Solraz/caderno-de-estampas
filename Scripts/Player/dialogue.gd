extends Control

@export var player: Player
@export var dialogue_box: RichTextLabel
@export var dialogue_page: Label

func _ready():
	self.get_parent().get_parent().visible = false
	self.visible = false
	dialogue_box.bbcode = player.stats.curr_diag
	dialogue_page.text = "%s/%s" % [player.stats.curr_diag_page + 1, player.stats.dialogue.size()]
	pass

func _input(event):
	if (!player.stats.dialoguing):
		return

	if (event.is_action_pressed("interact")):
		if (player.stats.curr_diag_page + 1 == player.stats.dialogue.size()):
			return

		player.stats.curr_diag_page += 1
		player.stats.curr_diag = player.stats.dialogue[player.stats.curr_diag_page]

		dialogue_box.bbcode = player.stats.curr_diag
		dialogue_page.text = "%s/%s" % [player.stats.curr_diag_page + 1, player.stats.dialogue.size()]
