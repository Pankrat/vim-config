setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=0
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal makeprg=pylint\ --output-format=parseable\ --reports=n\ %
setlocal efm=%f:%l:\ [%t]%m,%f:%l:%m
