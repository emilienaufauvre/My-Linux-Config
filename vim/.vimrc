" DISPLAY ------------------------------------------------------------------------------------------
" Name.
set title     
" Lines.
set number
set rnu    
set numberwidth=4
" Matching brackets. 
set showmatch
" Cursor.
set ruler
set cursorline
" Commands.
set showcmd
" Mouse.
set mouse=a
" Too long lines on multiple lines.
set wrap         
" Cursor blocking in middle of page.
set scrolloff=40
" Auto-closing.
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
" Map.
nnoremap <C-a> 0
nnoremap <C-e> $
" Search.
set ignorecase
set incsearch " Highlight during.
set hlsearch  " Highlight results.
" Auto-tab + replace tab with 4 spaces.
filetype plugin indent on  
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
" Auto completion with tab.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"
" Abbreviation. 
""iabbrev main int main(int argc, char *argv[
" 100 columns limit.
""highlight OverLength ctermbg=grey ctermfg=black guibg=#59292
""match OverLength /\%101v.\+/
""set colorcolumn=100 
""highlight ColorColumn ctermbg=10


" PLUGINS ------------------------------------------------------------------------------------------
" Pathes. 
runtime! config/**/*.vim
" Shortcuts.
call pathogen#infect()
call pathogen#helptags()

" THEME --------------------------------------------------------------------------------------------
syntax enable
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_improved_warnings=1
let g:gruvbox_number_column='bg1'
set background=dark
colorscheme gruvbox

" XCLIP --------------------------------------------------------------------------------------------
" Map copy/past with 'xclip'.
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" NERDTREE -----------------------------------------------------------------------------------------
" <F2> to open current or close.
nnoremap <silent> <leader>² :NERDTreeFind<CR>
nmap ² :NERDTreeToggle<CR>
" <Ctrl + x> to open in new tab. 
let NERDTreeMapOpenInTab='<C-x>'
" Remove these buttons. 
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" Open on start and on tab. 
autocmd VimEnter * NERDTree
autocmd BufWinEnter * NERDTreeMirror  
" Auto-closing if the last one is open.
function! s:CloseIfOnlyControlWinLeft()
	if winnr("$") != 1
		return
	endif
	if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
			\ || &buftype == 'quickfix'
		q
	endif
endfunction
augroup CloseIfOnlyControlWinLeft
	au!
    au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END"""
autocmd VimEnter * call CloseExtraNERDTree()
" If Vim start with a file; show this file + NERDTREE otherwise close the NERDTREE buffer.
function CloseExtraNERDTree()
  wincmd l " Move to right pane.
  let l:main_bufnr = bufnr('%') 
  let l:fname = expand('%') " Get name of current buffer.
  if l:fname ==# 'NERD_tree_1'
    exe bufwinnr(l:main_bufnr) . "wincmd w"
    bd
  endif
endfunction

" AIRLINE ------------------------------------------------------------------------------------------
" Right stuff simplified.
let g:airline_section_z = '[lignes %l / %L] [colonnes %c]'
" Display tab.
let g:airline#extensions#tabline#enabled = 1
" Powerline.
let g:airline_powerline_fonts = 0

" SYNTASTIC ----------------------------------------------------------------------------------------
" Loading errors. 
let g:syntastic_always_populate_loc_list=1
" User signs ∆ ✗ for simplified understanding.
let g:syntastic_error_symbol="X" 
let g:syntastic_warning_symbol="⚠"

" NEOCOMPLETE --------------------------------------------------------------------------------------
let g:neocomplete#enable_at_startup=1
