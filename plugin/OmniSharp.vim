if exists('g:OmniSharp_loaded') | finish | endif
let g:OmniSharp_loaded = 1

let g:OmniSharp_server_stdio = get(g:, 'OmniSharp_server_stdio', 0)

" Use mono to start the roslyn server on *nix
let g:OmniSharp_server_use_mono = get(g:, 'OmniSharp_server_use_mono', 0)

let g:OmniSharp_open_quickfix = get(g:, 'OmniSharp_open_quickfix', 1)

let g:OmniSharp_timeout = get(g:, 'OmniSharp_timeout', 1)

let g:OmniSharp_translate_cygwin_wsl = get(g:, 'OmniSharp_translate_cygwin_wsl', has('win32unix'))

let g:OmniSharp_typeLookupInPreview = get(g:, 'OmniSharp_typeLookupInPreview', 0)

let g:OmniSharp_BufWritePreSyntaxCheck = get(g:, 'OmniSharp_BufWritePreSyntaxCheck', 1)
let g:OmniSharp_CursorHoldSyntaxCheck = get(g:, 'OmniSharp_CursorHoldSyntaxCheck', 0)

let g:OmniSharp_sln_list_index = get(g:, 'OmniSharp_sln_list_index', -1)
let g:OmniSharp_sln_list_name = get(g:, 'OmniSharp_sln_list_name', '')

let g:OmniSharp_autoselect_existing_sln = get(g:, 'OmniSharp_autoselect_existing_sln', 1)
let g:OmniSharp_prefer_global_sln = get(g:, 'OmniSharp_prefer_global_sln', 0)
let g:OmniSharp_start_without_solution = get(g:, 'OmniSharp_start_without_solution', 0)

" Automatically start server
let g:OmniSharp_start_server = get(g:, 'OmniSharp_start_server', get(g:, 'Omnisharp_start_server', 1))

" Default value for python log level
let g:OmniSharp_loglevel = get(g:, 'OmniSharp_loglevel', 'warning')

" Default map of solution files and directories to ports.
" Preserve backwards compatibility with older version "g:OmniSharp_sln_ports
let g:OmniSharp_server_ports = get(g:, 'OmniSharp_server_ports', get(g:, 'OmniSharp_sln_ports', {}))

" Initialise automatic type and interface highlighting
let g:OmniSharp_highlight_types = get(g:, 'OmniSharp_highlight_types', 0)
if g:OmniSharp_highlight_types
  augroup OmniSharp#HighlightTypes
    autocmd!
    autocmd BufEnter *.cs call OmniSharp#HighlightBuffer()
  augroup END
endif

augroup OmniSharp#Integrations
  autocmd!

  " Initialize OmniSharp as an asyncomplete source
  autocmd User asyncomplete_setup call asyncomplete#register_source({
  \ 'name': 'OmniSharp',
  \ 'whitelist': ['cs'],
  \ 'completor': function('asyncomplete#sources#OmniSharp#completor')
  \})

  " Listen for ALE requests
  if g:OmniSharp_server_stdio
    function! s:ALEWantResults() abort
      if getbufvar(g:ale_want_results_buffer, '&filetype') ==# 'cs'
        call ale#sources#OmniSharp#WantResults(g:ale_want_results_buffer)
      endif
    endfunction
    autocmd User ALEWantResults call s:ALEWantResults()
  endif
augroup END

if !exists('g:OmniSharp_selector_ui')
  let g:OmniSharp_selector_ui = get(filter(
  \   ['unite', 'ctrlp', 'fzf'],
  \   '!empty(globpath(&runtimepath, printf("plugin/%s.vim", v:val), 1))'
  \ ), 0, '')
endif

" Set to 1 when ultisnips is installed
let g:OmniSharp_want_snippet = get(g:, 'OmniSharp_want_snippet', 0)

let g:omnicomplete_fetch_full_documentation = get(g:, 'omnicomplete_fetch_full_documentation', 0)

let g:OmniSharp_proc_debug = get(g:, 'OmniSharp_proc_debug', get(g:, 'omnisharp_proc_debug', 0))

" vim:et:sw=2:sts=2
