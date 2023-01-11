set ignorecase
set clipboard=unnamed
set incsearch
set hlsearch
set backspace=indent,eol,start

if has('ide')
    nnoremap <Space> <NOP>
    nnoremap <C-n> <NOP>
    let mapleader=" "
    map <leader>F <Action>(FindInPath)
    map <leader>b <Action>(ReSharperGotoImplementation)
    map <leader>B <Action>(GotoDeclaration)
    map <leader>u <Action>(FindUsages)
    map <leader>n <Action>(GotoClass)
    map <leader>N <Action>(GotoFile)
    map <C-,> <Action>(Back)
    map <C-Shift-.> <Action>(Forward)
    map <leader>- <Action>(CollapseRegion)
    map <leader>+ <Action>(ExpandRegion)
else
    nnoremap <Space> <NOP>
    map <Space>B :vsc Resharper.ReSharper_GotoDeclaration<CR>
    map <Space>b :vsc Resharper.Resharper_GotoImplementations<CR>
    map <C-,> :vsc Resharper.Resharper_NavigateBackward<CR>
    map <C-.> :vsc Resharper.Resharper_NavigateForward<CR>
    map <Space>u :vsc Resharper.ReSharper_FindUsages<CR>
    map <Space>n :vsc Resharper.ReSharper_GotoType<CR>
    map <Space>N :vsc Resharper.ReSharper_GotoFile<CR>
endif
