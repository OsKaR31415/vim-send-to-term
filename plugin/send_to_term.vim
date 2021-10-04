
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
nnoremap <leader>x :SendToTerm<cr>
vnoremap <leader>x :SendToTerm<cr>

