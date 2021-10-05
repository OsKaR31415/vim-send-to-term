
fun! s:send_to_term(lnum1, lnum2, arg)
    " get terminal buffer
    let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
    " open new terminal if it doesn't exist
    if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
        vert term
        let g:terminal_buffer = bufnr('')
        wincmd p
        " split a new window if terminal buffer hidden
    elseif bufwinnr(g:terminal_buffer) == -1
        exec 'sbuffer ' . g:terminal_buffer
        wincmd p
    endif
    " if no argument is given
    if a:arg == ""
        " join lines with "\<cr>", note the extra "\<cr>" for last line
        " send joined lines to terminal.
        call term_sendkeys(g:terminal_buffer,
                    \ join(getline(a:lnum1, a:lnum2), "\<cr>") . "\<cr>")
    else
        " simlply send the argument
        call term_sendkeys(g:terminal_buffer, a:arg."\<cr>")
    endif
endfun

" nargs=* because no arguments are possible and because any number of
" arguments is considered as one
command! -nargs=* -range SendToTerm call s:send_to_term(<line1>, <line2>, <q-args>)



nnoremap <silent> <leader>x :set opfunc=Surround<cr>g@
vnoremap <silent> <leader>x :<c-u>call Surround(visualmode(), 1)<cr>

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! OperatorSendToTerm(vt, ...)
    " let s = InputChar()
    " if s =~ "\<esc>" || s =~ "\<c-c>"
    "     return
    " endif
    let [sl, sc] = getpos(a:0 ? "'<" : "'[")[1:2]
    let [el, ec] = getpos(a:0 ? "'>" : "']")[1:2]

    " visual selection
    if a:vt == 'line' || a:vt == 'V'
        exe "SendToTerm " . s:get_visual_selection()
    " visual block
    elseif a:vt == 'block' || a:vt == "\<c-v>"
        " exe sl.','.el 's/\%'.sc.'c\|\%'.ec.'c.\zs/\=s/g|norm!``'
        " for the moment, it is line-wise
        '<,'>SendToTerm
    " normal mode
    else
        call setpos('.', getpos("'["))
        normal! v
        call setpos('.', getpos("']"))
        exe "SendToTerm " . s:get_visual_selection()
        normal! "o"
    endif
endfunction


nnoremap <silent> <leader>x :set opfunc=OperatorSendToTerm<cr>g@

