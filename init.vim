"----------------------------------------------------------------
" Plugins
"----------------------------------------------------------------

call plug#begin('~/AppData/Local/nvim/plugged')
  Plug 'junegunn/vim-easy-align'
  Plug 'derekwyatt/vim-fswitch'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'
call plug#end()

"----------------------------------------------------------------
" Settings
"----------------------------------------------------------------

" theme 
colorscheme dosbox-black
set background=dark

"disable screen flash when there is no buffer to scroll
set visualbell t_vb=

" enable backspace in INSERT
set backspace=indent,eol,start

" disable "SEARCH HIT BOTTOM..." after "ta"
set shortmess+=s

" makes buffer navigation sane
set wildmode=list:full

" clang and cl error parser
set errorformat=%f(%l):\ %m

" auto-align new-line function arguments
set smartindent
set cindent
set cino+=(0
set cinoptions+=l1
set cinoptions+=:0

set softtabstop=2
set shiftwidth=2
set expandtab
set tabstop=2
set textwidth=0 
set wrapmargin=0

" find ctags search path to current directory
set tags=./.ctags,tags;$HOME

" enable relative numbers
set number relativenumber

" text wrapping
set nowrap

" marker for max column width
set colorcolumn=120

" gather swap files in one place (by default swaps are next to files being edited and it makes difficult to delete or move directories)
set backupdir=~/vimtmp,.
set directory=~/vimtmp,.
set dir=c:\vim_swapfiles
set backupdir=c:\vim_swapfiles
set nobackup
set noundofile

" search
set ignorecase
set incsearch

"set hidden
set clipboard=unnamed
set clipboard+=unnamedplus

" Ctrl+c in visual mode
vnoremap <C-c> "+y

"----------------------------------------------------------------
" Highlight
"----------------------------------------------------------------

highlight ColorColumn guibg=#1e1e1e

" idk why but default color for completion menu is pink
highlight Pmenu ctermbg=234 ctermfg=255 guibg=#1e1e1e guifg=#dcdcdc

" disable highlight for matching parens
highlight! clear MatchParen

" automatically clear search highlight when pressing <Esc>
augroup SearchHighlight
  autocmd!
  " Enable search highlight when entering search mode
  autocmd CmdlineEnter /,? :set hlsearch
  " Disable search highlight when leaving search mode (Esc or normal mode)
  autocmd CmdlineLeave /,? :set nohlsearch
augroup END

" change cursor line to under line
set cursorline
"hi clear CursorLine
"hi CursorLine gui=underline cterm=underline

"----------------------------------------------------------------
" ctags
"----------------------------------------------------------------

" register ctags command
command! GenerateTags !ctags -R src

"----------------------------------------------------------------
" Build
"----------------------------------------------------------------

set makeprg=cmd\ /c\ build.bat
command! MakeQuickFixStay call s:MakeQuickFixStay()
command! -nargs=* MakeQuickFix silent! make <args> | botright copen
function! s:MakeQuickFixStay()
  let l:win = win_getid()
  let l:pos = getpos('.')
  execute 'MakeQuickFix san radlink'
  call win_gotoid(l:win)
  call setpos('.', l:pos)
endfunction

"----------------------------------------------------------------
" Key Maps
"----------------------------------------------------------------

" generate ctags for "src" folder
nmap <F1> :GenerateTags<CR>

" close quick window
nmap <F2> :ccl <CR>

" swap between c and header files
nmap <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <F5> :MakeQuickFixStay<CR>

" helper for switching between .c/.cpp and .h files
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>

" never use and always miss-type
nmap H <nop>
nmap L <nop>

" easy aling
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" map swap buffers to ALT+1
nnoremap <A-1> :b#<CR>

nmap <leader>b :b<Space>
nmap <leader>e :e<Space>
nmap <leader>m :make<Space>san<Space>
nmap <leader>t :ta<Space>
nmap <leader>c :MakeQuickFixStay<Enter>

nmap <F7> :cn<cr>

"----------------------------------------------------------------
" gitsings
"----------------------------------------------------------------

" remove gisigns from the status line
let g:airline#extensions#hunks#enabled = 0

lua require('gitsigns').setup()

"----------------------------------------------------------------
" Airline
"----------------------------------------------------------------

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" berkeley mono does not this glyph
let g:airline_symbols.modified = ''
let g:airline_symbols.branch = ''

" disable pointless separators on the right side
let g:airline#extensions#nvimlsp#enabled = 0

" show git on the status line
let g:airline#extensions#fugitiveline#enabled = 1

" disable right-most warning for mixed-indent-files
let g:airline#extensions#whitespace#enabled=0

let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#netrw#enabled = 0
let g:airline#extensions#xkblayout#enabled = 0

" disable tab line
let g:airline#extensions#tabline#enabled=0

" theme
let g:airline_theme='base16_ia_dark'

" line number & column
let g:airline_section_x='(%l, %c)'

" file format
let g:airline_section_y='%{&ff}'

" last modify time stamp
let g:airline_section_z='%{strftime("%H:%M:%S | %d-%m-%Y ", getftime(expand("%:p")))}'

let g:airline_powerline_fonts = 1

let g:airline_detect_modified = 0

"AirlineTheme base16_helios

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"----------------------------------------------------------------
" Indent Blankline
"----------------------------------------------------------------

lua << EOF

local highlight = {
  "White",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "White", { fg = "#333333" })
end)

require("ibl").setup {
  indent = {
    char = "▏",
    highlight = highlight
  }
}

EOF

