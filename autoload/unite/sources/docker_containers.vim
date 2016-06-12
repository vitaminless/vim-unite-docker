let s:unite_source = {
	\ 'name':        'docker/containers',
	\ 'description': 'list all docker containers',
\ }

function! s:unite_source.gather_candidates(args, context)
	let containers = split(system('docker ps -a'), '\n')
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
				\ 'kind': 'docker/container',
				\ 'action_word': data[2]
			\ }
		\ )
	endfor
	return result
endfunction

function! unite#sources#docker_containers#define()
	return s:unite_source
endfunction
