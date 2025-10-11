_FileDataDestroyedText::
	text "The file data is"
	line "destroyed!"
	autodone

_SavingText::
	text "Saving..."
	done

_GameSavedText::
	text "<PLAYER> saved"
	line "the game!"
	done

_OlderFileWillBeErasedText::
	text "The older file"
	line "will be erased to"
	cont "save. Okay?"
	done

_ChooseABoxText::
	text "Choose a"
	line "<PKMN> BOX.@"
	text_end

_EvolvedText::
	text_ram wStringBuffer
	text " evolved"
	done

_IntoText::
	text_start
	line "into @"
	text_ram wNameBuffer
	text "!"
	done

_StoppedEvolvingText::
	text "Huh? @"
	text_ram wStringBuffer
	text_start
	line "stopped evolving!"
	autodone

_SortItemsText::
	text "Would you like to"
	next "sort items?"
	done

_SortComplete::
	text "Sorting is"
	next "Complete."
	autodone

_NothingToSort::
	text "There is nothing"
	next "to sort."
	autodone
