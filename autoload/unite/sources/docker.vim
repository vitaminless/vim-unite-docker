let s:unite_source = {
	\ 'name': 'docker',
	\ 'description': 'docker related commands',
\ }

let s:unite_source_docker_command_list = [
	\ { 'word': 'List images',             'kind': 'docker', 'action_command': 'Unite docker/images',     },
	\ { 'word': 'List running containers', 'kind': 'docker', 'action_command': 'Unite docker/running',    },
	\ { 'word': 'List all containers',     'kind': 'docker', 'action_command': 'Unite docker/containers', },
\ ]

function! s:unite_source.gather_candidates(args, context)
	return s:unite_source_docker_command_list
endfunction

function! unite#sources#docker#define()
	return s:unite_source
endfunction
