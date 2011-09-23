func! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endf

func! ShowTab()
	let TabLevel = (indent('.') / &ts )
	if TabLevel == 0
		let TabLevel='*'
	endif
	return TabLevel
endf

func! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endf
"map <Leader>f :call ShowFuncName() <CR>

