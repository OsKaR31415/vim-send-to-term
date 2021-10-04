# vim-send-to-term

This plugin define only one command that allows you to send some text in a vim terminal-window.

It is made to be as simple as possible, and it only implements very basic functions : sending selected text or sending defined text. It is free to you to extend it as you wish.

# Basic usage

The plugin defines the command `SendToTerm` that opens (if not already open) a terminal window in vim, and sends the argument it got.

There are 2 ways to use the command.


## Passing as an argument

The first method is to pass the string you want to send to the terminal as ad argument to the command.

#### Syntax :

`:SendToTerm [here the text to send to the terminal]`

#### Example :

`:SendToTerm "ls"`


## Using Visual selection

The second method is to use the command after performing a visual selection.
Vim does prefix the command by `'<'>`.
When you use the `SendToTerm` command after a visual selection, it will ignore any argument, and use the current visual selection (linewise, as vim passes only the beginning and ending lines numbers).

#### Syntax :

What you have to type :
`[perform a visual sellection]:SendToTerm`

Sends to terminal the visual selection you just did.

#### Example :

`vip:SendToTerm<cr>`

That will send the current paragraph to the terminal.

# What the plugin isn't doing

 - This plugin cannot connect to an existing terminal window
 - This plugin cannot change the connected terminal to another (you could do it by hand with the variable `let g:terminal_buffer`)
 - This plugin does not (for the moment) implement an operator to send text to the terminal



