let s:kind = {
	\ 'name': 'docker',
	\ 'default_action': 'execute',
	\ 'action_table': { 'execute': { 'is_selectable': 1, }, },
	\ 'parents': [],
\ }

function! s:kind.action_table.execute.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif
	execute a:candidates[0].action_command
endfunction

function! unite#kinds#docker#define()
	return s:kind
endfunction
