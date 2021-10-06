# vim-send-to-term

This plugin defines a way to send some text in a vim terminal window.

It is made to be as simple as possible, and it only implements very basic functions : sending selected text, sending arguments of a command, or sending with an operator. It is free to you to extend it as you wish.

# Basic configuration

## Installation

To install that plugin, use Vundle (or any other plugin manager) :

```vim
Plugin 'OsKaR31415/vim-send-to-term'
```

# Basic usage

The plugin defines the `SendToTerm` command, and the `OperatorSendToTerm` function that is used to define an operator

## The `SendToTerm` command

The `SendToTerm` command sends its argument to the terminal attached. If no terminal is attached, it creates a new one.

The command also accepts using ranges (like with `'<,'>SendToTerm`). This allows you to send the contents of a visual selection.

### Passing as an argument

The first method is to pass the string you want to send to the terminal as ad argument to the command.

#### Syntax :

`:SendToTerm [here the text to send to the terminal]`

#### Example :

`:SendToTerm "ls"`


### Using Visual selection

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


## Operator to send to terminal

To define the operator, you shall add to your `.vimrc` these lines :

```vim
" normal mode mapping
nnoremap <silent> <leader>x :set opfunc=OperatorSendToTerm<cr>g@
" visual mode mapping
vnoremap <silent> <leader>x :<c-u>call OperatorSendToTerm(visualmode(), 1)<cr>
```

In these 2 lines, the operator is mapped to `<leader>x`. But you are
free to change that as you wish.

# What the plugin isn't doing

 - This plugin cannot connect to an existing terminal window
 - This plugin cannot change the connected terminal to another (you could do it by hand changing the variable `let g:terminal_buffer`)



