
EventTypeName = EventTypeName or {
	"game_enter", 
	"create_fight_view",
	"create_main_ui_view",
}

EventType = EventType or helper.reverseTable(EventTypeName)
--- e.g. EventManager.addListener(EventType.game_enter, self.openView, self)