let s:unite_source = {
	\ 'name':        'docker/running',
	\ 'description': 'list running docker containers',
\ }

function! s:unite_source.gather_candidates(args, context)
	let containers = split(system('docker ps'), '\n')
	let result = [
		\ {
			\ 'word': remove(containers, 0),
			\ 'is_dummy': 1,
		\ },
	\ ]
	for container in containers
		let data = split(container, '\s\+')
		call add(
			\ result,
			\ {
				\ 'word': container,
				\ 'kind': 'docker/running',
				\ 'action_word': data[0]
			\ }
		\ )
	endfor
	return result
endfunction

function! unite#sources#docker_running#define()
	return s:unite_source
endfunction
