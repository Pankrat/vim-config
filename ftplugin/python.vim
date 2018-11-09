setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=0
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal makeprg=pylint\ --output-format=parseable\ --reports=n\ %
setlocal efm=%f:%l:\ [%t]%m,%f:%l:%m

iab pdb import ipdb; ipdb.set_trace()

noremap <f5> :AsyncRun -raw django-admin test % --logging-level=ERROR --nologcapture --with-id --with-progressive<cr>
noremap <C-f5> :!django-admin test % -s --logging-level=ERROR --nologcapture --with-id --with-progressive<cr>
let g:asyncrun_open = 8
