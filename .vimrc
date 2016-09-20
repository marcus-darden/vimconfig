" Spacing and rulers
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Syntax, colors, and fonts
set bg=dark
set syntax=python

" Window embellishments
set modeline
set ls=2
set ruler
set number

" Editor behavior
set hidden
set showmatch
set showmode
set backspace=indent,eol,start
set wildmode=longest,list,full
set wildmenu

" Movement
map <C-H> <C-W>h
map <C-L> <C-W>l
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-N> gT
map <C-M> gt

" Pathogen
execute pathogen#infect()

" NERDTree
autocmd vimenter * NERDTree
let NERDTreeIgnore = ['\~$', '\.pyc[[file]]']
let NERDTreeWinSize = 20
let NERDTreeDirArrows = 0

" Suggested
"syntax on
"filetype plugin indent on

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
ca shell Shell

