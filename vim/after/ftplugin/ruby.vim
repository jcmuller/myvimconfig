if v:version >= 704
	set regexpengine=1
endif

if !exists( "*RubyEndToken" )

  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*|\(,\|\s\|\w*|\s*\)\?$'
    let stuff_without_do = '^\s*class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\|do'
      let with_do = 'do\s*|\(,\|\s\|\w*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>"
      endif
    endfunction

endif

imap <buffer> <S-CR> <C-R>=RubyEndToken()<CR>
