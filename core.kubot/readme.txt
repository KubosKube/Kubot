
This is a README for Kubot! I'm Kubos, and I'll be your guide as I describe each part of the Core and why I made it the way I did.



#-#-#-#-# .ini Handling #-#-#-#-#
Please note that reading and writing to a file with $readini or /writeini does not have anything to do with the name or extension of the file, but the structure of the data inside.

$kubot.readini($1=AliasName, $2=.FileSuffix, $3=Section, $4=Item, $5=OverrideFilename)

	I made this to read files in the same folder as my script.
	$1 The alias used can be any alias in the file, because Kubot only uses it to get the Filename.
	$2 The File Suffix is spliced onto the end of the Filename.
	$3 The section works the same as a regular call to $readini
	$4 The item works the same as a regular call to $readini
	$5 In case you are trying to read from a file named something other than the alias's Filename.suffix, you can specify an optional override so that this command reads from Override.suffix instead.

/kubot.writeini $1=AliasName $2=.FileSuffix $3=Section $4=Item $5=Data $6=OverrideFilename

	I made this to as a counterpart to $kubot.readini, and as such, it is largely the same.
	$1 The alias used can be any alias in the file, because Kubot only uses it to get the Filename.
	$2 The File Suffix is spliced onto the end of the Filename.
	$3 The section works the same as a regular /writeini command.
	$4 The item works the same as a regular /writeini command.
	$5 The data input works the same as a regular /writeini command.
	$6 In case you are trying to write to a file named something other than the alias's Filename.suffix, you can specify an optional override so that this command writes to Override.suffix instead.

$kubot.config($1=AliasName, $2=Item)
/kubot.config $1=AliasName $2=Item $3=Data

	I made this to read contents of config files. It is vastly simpler than $kubot.readini or /kubot.writeini.
	$1 The alias used can be any alias in the file, because Kubot only uses it to get the Filename.
	$2 The item works the same as a regular $readini command.
	$3 If this identifier exists, whether or not it is being used as a /command or an $identifier, it will modify the config file to replace the current item's data with new data.



#-#-#-#-# Command Translator #-#-#-#-#

alias kubot.cht.command {
	
	; I got tired of typing out an "on *:TEXT::#:" event for every chat command I wished to implement, so I made this charm of a script.
	; If you wish to add a new chat command to your script at little to no effort, just copy the alias straight from this readme file, and paste it into your script.
	; In "kubot.cht.command", replace "command" with whatever your chat command is.
	; For example, "!dice 2 6" would translate to "/kubot.cht.dice 2 6"
	; DO NOTE, however, that the chat command "!dice 2 6" would read as $1=!dice, $2=2, $3=6, but the translated command "kubot.cht.dice 2 6" will read as $1=2, $2=6.

}




#-#-#-#-# MRC Creator #-#-#-#-#

/kubot.newscript $1=load/noload $2=ScriptName

	I rather dislike manually creating files and fabricating the filepath to keep the file in. I also figured that since I plan to heavily compartmentalize my future scripts that this command would be very handy for me.
	$1 This is either "load", or literally anything else. If it is set to "load", then when the files are created, they are automatically loaded by Kubot.
	$2 This is the name of your script. It determines the automatic storage and filename generation for your new script. The path is as follows:

	┌───────────────────────────────┐
        │ $mircdir\                     │
        │ └─ scripts\                   │
        │    └─ Kubot-Scripts\          │
        │       └─ ScriptName\          │
        │          ├─ ScriptName.mrc    │
        │          ├─ ScriptName.dialog │
        │          ├─ ScriptName.config │
        │          └─ readme.text       │
        └───────────────────────────────┘




#-#-#-#-# Dialog Boxes #-#-#-#-#

/core.kubot.dialog

	This is a really simple dialog. It launches the Script Manager.


/dialog -m core.Kubot.ScriptManager core.Kubot.ScriptManager

	This is the biggest part of Kubot. The buttons in the manager are pretty self-explanatory.
	The three list boxes in the middle of the dialog are where your scripts will show up. Any new scripts will be in the middle, and will be ignored by Kubot entirely.
	Highlighting any number of scripts in any combination in any of the three lists and then pressing one of the "Mark to X" buttons will move all of the highlighted scripts into the box correlating to the button.
	Changes will not be made until either of the Save buttons are pressed.
	If "Save and Update" is clicked, the dialog will close and all changes will be made instantly, loading or unloading files as necessary.

	*Note:
		If you double-click any script in any of the three boxes, mIRC will open the folder where the script is located.

dialog -m core.kubot.newscript.dialog core.kubot.newscript.dialog

	This is a visual interface for using the MRC Creator to make new scripts. It's pretty self-explanatory.