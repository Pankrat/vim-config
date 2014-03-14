if has("gui_running")
    map <buffer> ,t :AsyncShell REUSE_DB=1 test_acceptance -c --stop -i %<cr>
else
    map <buffer> ,t :!REUSE_DB=1 test_acceptance --stop -i %<cr>
endif
