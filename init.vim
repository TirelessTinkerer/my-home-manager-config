"" Set plugin directory
call plug#begin()

"" vim-solarized8 (color theme)
Plug 'lifepillar/vim-solarized8'

"" vim-airline (better status bar)
Plug 'vim-airline/vim-airline'

"" vim-airline themes (status bar themes)
Plug 'vim-airline/vim-airline-themes'

"" vim-surround (easily delete, change, and add surroundings in pairs)
Plug 'tpope/vim-surround'

"" vim-commentary (Comment stuff out...)
Plug 'tpope/vim-commentary'

"" fzf (fuzzy finder)
"""" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" nerdtree (tree explorer)
Plug 'scrooloose/nerdtree'

"" vim-clang-format
Plug 'rhysd/vim-clang-format'

"" coc (lsp)
"" I don't want to build Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}


"" Initialize plugin system
call plug#end()
silent! colorscheme solarized8_low

"""""""""
"" fzf ""
"""""""""

"" Remap ESC for fzf so that it exits the search pane when pressed.
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

"" Mapping for file search pane.
nmap <silent> mo :GFiles<CR>

