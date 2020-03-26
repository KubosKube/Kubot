/*

    Kubot v0.1

*/

on *:START: {
  core.kubot.dialog
}

;#### System .Ini Handlers ####;
; Kubot is intended to handle .ini, .mrc, and .config files, but should handle any other suffix as long as the contents are plain text.

alias kubot.readini {
  ; Reads from files in Kubot's folders
  ; Use as an identifier: $kubot.readini($1=AliasName, $2=.FileSuffix, $3=Section, $4=Item, $5=OverrideFilename)

  if (!$5) {
    ; Default method (4 inputs) reads from the file $isalias($1).fname with the suffix $2.
    var %filename.readini $replace($isalias($1).fname, .mrc, $2)
  }

  else {
    ; Alternate method (5 inputs) reads from the file named $5 with the suffix, $2.
    var %filename.readini $replace($isalias($1).fname,$nopath($isalias($1).fname), $5 $+ $2)
  }

  var %result $readini(%filename.readini, $3, $4)
  ;echo -a %result
  return %result
}

alias kubot.writeini {
  ; Writes to files in KubosKubot's folders
  ; Use as a command: /kubot.writeini $1=AliasName $2=.FileSuffix $3=Section $4=Item $5=Data $6=OverrideFilename

  if (!$6) {
    ; Default method (5 inputs) makes a file named $isalias($1).fname with the suffix, $2.
    var %filename.writeini $replace($isalias($1).fname, .mrc, $2)
  }

  else {
    ; Alternate method (6 inputs) makes a file named $6 with the suffix, $2
    var %filename.writeini $replace($isalias($1).fname,$nopath($isalias($1).fname), $6 $+ $2)
  }

  var %result %filename.writeini
  ;echo -a %result
  writeini %filename.writeini $3 $4 $5
}

alias kubot.config {
  ;Reads or writes to the parent file's config.

  if (!$3) {
    ; Use as an identifier: $kubot.config($1=AliasName, $2=Item)
    ; Default method (2 inputs) reads from the file AliasName.config and returns the Data from the Item from the section [Config]
    var %result $kubot.readini($1, .config, Config, $2)
    return %result
  }

  else {
    ; Use as a command: /kubot.config $1=AliasName $2=Item $3=Data
    ; Alternate method (3 input) writes Data to an Item in the section [Config] of AliasName.config.
    kubot.writeini $1 .config Config $2 $3
  }
}

;#### Command Translator ####;
on *:TEXT:!*:#: {
  ; Transform the command "!command" into a call to alias "kubot.cht.command"
  if ($kubot.config(kubot.config, enable_command_translater) == true) {
    var %translate.command $replace($1,!,kubot.cht.)
    echo -a %translate.command
    ; Check to see if "kubot.cht.command" is a valid alias.
    if ($isalias(%translate.command)) {
      ; Run the alias "kubot.cht.command" with any additional parameters.
      $eval(%translate.command $2-)
    }
  }
}

;#### MRC Creator ####
; Make a new script and store it in a folder.
; /kubot.newscript $1=load/noload $2=ScriptName

alias kubot.newscript {
  ; Set up the variables for Filename and Filepath, and make a Folder to store the files in.
  var %instruction $1
  var %filename $2
  var %filepath $mircdir $+ \scripts\Kubot-Scripts\ $+ %filename $+ \
  mkdir %filepath

  ; Set up files inside of the new folder.
  write %filepath $+ %filename $+ .mrc This is intended to be your main MRC file. I encourage that you use it as a library for other commands, particularly chat commands. See the file structure for core.kubot for an example. You can of course use this however you see fit, my recommendation is just a suggestion.
  write %filepath $+ %filename $+ .dialog This is intended to store your Dialog structures, and the commands for your dialog buttons. See core.kubot.dialog for an example. You can of course use this however you see fit, my recommendation is just a suggestion.
  write %filepath $+ %filename $+ .config This is intended to store your configuration options. Along with regular /writeini and $ $+ readini , you can modify it with /kubot.writeini and you can read it with $ $+ kubot.readini . You can optionally do both with /kubot.config or $ $+ kubot.config , just read the readme for core.kubot to see detailed instructions on how to do either.
  write %filepath $+ readme.text This is where I recommend you explain how your plugin works.

  ; If specified to load automatically, then this loads the script as soon as it's created.
  if (%instruction == load) {
    load -rs %filepath $+ %filename $+ .mrc
    load -rs %filepath $+ %filename $+ .dialog
  }
}