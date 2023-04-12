
function! lsp_popup_diagnostics#show() abort
  let fpath = expand("%:p")
  let lineno = line(".") - 1

  let result = lsp#internal#diagnostics#state#_get_all_diagnostics_grouped_by_uri_and_server()   
  for key in keys(result)
    " endswith
    if key[len(key)-len(fpath):] !=? fpath
      continue
    endif

    " item : gopls
    for item in items(result[key])
      for value in item[1].params.diagnostics
        " check line
        if value.range.start.line != lineno
          continue
        endif
        " show message
        let msg =  [value.message]
        call popup_create(msg, {
              \ 'moved': 'any',
              \ 'col'  : 'cursor',
              \ 'line' : 'cursor+1',
              \ 'padding': [0,1,0,1]})
        return
      endfor
    endfor

    return
  endfor
endfunction
