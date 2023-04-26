" Customize global settings
call ddc#custom#patch_global({
    \ 'ui': 'pum',
    \ 'sources': ['nvim-lsp', 'around', 'rg', 'file'],
    \ 'cmdlineSources': {
    \   ':': ['cmdline','cmdline-history', 'file', 'around'],
    \ },
    \ 'autoCompleteEvents': [
    \   'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged',
    \ ],
    \ 'sourceOptions': #{
    \   _: #{
    \     matchers: ['matcher_fuzzy'],
    \     sorters: ['sorter_fuzzy'],
    \     converters: ['converter_fuzzy']
    \   },
    \   nvim-lsp: #{
    \     ignoreCase: v:true,
    \     mark: 'lsp',
    \     forceCompletionPattern: '\.\w*|:\w*|->\w*' 
    \   },
    \   around: #{
    \     mark:'a',
    \     ignoreCase: v:true 
    \   },
    \   rg: #{
    \     mark:'rg',
    \     ignoreCase: v:true 
    \   },
    \   cmdline: #{
    \     mark:'cmd',
    \     ignoreCase: v:true 
    \   },
    \   cmdline-history: #{
    \     mark:'hist',
    \     ignoreCase: v:true 
    \   },
    \   file: #{
    \     mark:'file',
    \     ignoreCase: v:true 
    \   },
    \ },
    \ 'sourceParams' : #{
    \   around: #{ maxSize: 500 },
    \ },
    \ 'uiParams': #{
    \   pum: #{ insert: v:false },
    \ },
    \ })
nnoremap :       <Cmd>call CommandlinePre()<CR>:

inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>


" pum settings of command line
function! CommandlinePre() abort
    cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
    cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
    cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
    " cmap <expr><CR>   pum#visible() ? '<C-y>' : '<CR>'
    cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

    autocmd User DDCCmdlineLeave ++once call CommandlinePost()

    " Enable command line completion for the buffer
    call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
    silent! cunmap <Tab>
    silent! cunmap <S-Tab>
    silent! cunmap <C-n>
    silent! cunmap <C-p>
    silent! cunmap <C-y>
    silent! cunmap <CR>
    silent! cunmap <C-e>
endfunction



call ddc#enable()

