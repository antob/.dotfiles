" Disable backup for gopass files.
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
