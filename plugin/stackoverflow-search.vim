" stackoverflow-search.vim
" Version:      0.1

if exists('g:loaded_stackoverflow_search_plugin') || &compatible || v:version < 700
	finish
endif
let g:loaded_stackoverflow_search_plugin = 1

function! g:GetVisualSelection()
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

function! g:SearchStackOverflow()
	execute ':silent !command xdg-open https://stackoverflow.com/search?q=' . GetVisualSelection()
endfunction

command! -bar -bang SearchStackOverflow call SearchStackOverflow()
nnoremap <Leader>ft :call SearchStackOverflow()<CR>
