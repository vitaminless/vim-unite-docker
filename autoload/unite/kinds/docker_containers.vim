let s:kind = {
	\ 'name': 'docker/container',
	\ 'default_action': 'inspect',
	\ 'action_table': {
		\ 'inspect': { 'is_selectable': 1, 'description': 'inspect this container', },
		\ 'start':   { 'is_selectable': 1, 'description': 'start this container', },
		\ 'remove':  { 'is_selectable': 1, 'description': 'remove this container', },
	\ },
	\ 'parents': [],
\ }

function! s:kind.action_table.inspect.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker inspect ' . a:candidates[0].action_word)
endfunction

function! s:kind.action_table.start.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker start ' . a:candidates[0].action_word)
endfunction

function! s:kind.action_table.remove.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker rm ' . a:candidates[0].action_word)
endfunction

function s:docker_cmd(cmd)
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap filetype=json fileencoding=utf-8
	execute 'silent 0read! ' . a:cmd
	execute 'silent %s/\\u\(\x\{4\}\)/\=nr2char("0x".submatch(1),1)/g'
	execute 'silent %s/\\t/\t/g'
	setlocal nomodifiable
	execute 'silent 0'
endfunction

function! unite#kinds#docker_containers#define()
	return s:kind
endfunction
