
function! lsp_popup_diagnostics#show() abort
  let result = lsp#internal#diagnostics#state#_get_all_diagnostics_grouped_by_uri_and_server()   
  let fpath = 'file://' . expand("%:p")

  if !has_key(result, fpath)
    return
  endif

  let lineno = line(".") - 1
  for item in items(result[fpath])
    for value in item[1].params.diagnostics
      if value.range.start.line != lineno
        continue
      endif
      let msg =  [value.message]
      call popup_create(msg, {'moved': 'any', 'line' : 'cursor+1', 'padding': [0,1,0,1]})
      
    endfor
  endfor
endfunction
