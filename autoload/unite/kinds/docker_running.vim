let s:kind = {
	\ 'name': 'docker/running',
	\ 'default_action': 'inspect',
	\ 'action_table': {
		\ 'inspect': { 'is_selectable': 1, 'description': 'inspect this image', },
		\ 'port':    { 'is_selectable': 1, 'description': 'list ports of this image', },
		\ 'logs':    { 'is_selectable': 1, 'description': 'show logs of this container', },
		\ 'top':     { 'is_selectable': 1, 'description': 'show the processes of the container', },
		\ 'pause':   { 'is_selectable': 1, 'description': 'pause the container', },
		\ 'unpause': { 'is_selectable': 1, 'description': 'unpause the container', },
		\ 'stop':    { 'is_selectable': 1, 'description': 'stop the container', },
		\ 'restart': { 'is_selectable': 1, 'description': 'restart the container', },
		\ 'kill':    { 'is_selectable': 1, 'description': 'kill the container', },
		\ 'remove':  { 'is_selectable': 1, 'description': 'remove the container', },
	\ },
	\ 'parents': [],
\ }

function! s:kind.action_table.inspect.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker inspect ' . a:candidates[0].action_word)
	setlocal modifiable fileencoding=utf-8 filetype=json
	execute 'silent %s/\\t/\t/g'
	execute 'silent %s/\\u\(\x\{4\}\)/\=nr2char("0x".submatch(1),1)/g'
	setlocal nomodifiable
endfunction

function! s:kind.action_table.port.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker port ' . a:candidates[0].action_word)
endfunction

function! s:kind.action_table.logs.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker logs ' . a:candidates[0].action_word)
endfunction

function! s:kind.action_table.top.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	call s:docker_cmd('docker top ' . a:candidates[0].action_word)
endfunction

function! s:kind.action_table.pause.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker pause ' . a:candidates[0].action_word
endfunction

function! s:kind.action_table.unpause.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker unpause ' . a:candidates[0].action_word
endfunction

function! s:kind.action_table.stop.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker stop ' . a:candidates[0].action_word
endfunction

function! s:kind.action_table.restart.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker restart ' . a:candidates[0].action_word
endfunction

function! s:kind.action_table.kill.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker kill ' . a:candidates[0].action_word
endfunction

function! s:kind.action_table.remove.func(candidates)
	if len(a:candidates) != 1
		echo "candidates must be only one"
		return
	endif

	execute '!docker rm -f ' . a:candidates[0].action_word
endfunction

function s:docker_cmd(cmd)
	botright new
	execute 'silent 0read! ' . a:cmd
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nomodifiable
	execute 'silent 0'
endfunction

function! unite#kinds#docker_running#define()
	return s:kind
endfunction
