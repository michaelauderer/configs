autocmd BufRead /tmp/sql* set filetype=mysql
autocmd BufRead /tmp/mutt-* set filetype=mail textwidth=72

autocmd WinEnter,BufRead * set relativenumber
autocmd WinLeave * set number
