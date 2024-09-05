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
    map <C-.> <Action>(Forward)
    map <leader>- <Action>(CollapseRegion)
    map <leader>= <Action>(ExpandRegion)
else
    nnoremap <Space> <NOP>
    let mapleader=" "
    map <leader>N <Action>(workbench.action.quickOpen)
    map <leader>b <Action>(editor.action.goToDeclaration)
endif
