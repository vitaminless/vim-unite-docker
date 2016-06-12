let s:unite_source = {
	\ 'name':        'docker/images',
	\ 'description': 'list docker images',
\ }

function! s:unite_source.gather_candidates(args, context)
	let images = split(system('docker images'), '\n')
	let result = [
		\ {
			\ 'word': remove(images, 0),
			\ 'is_dummy': 1,
		\ },
	\ ]
	for image in images
		let data = split(image, '\s\+')
		call add(
			\ result,
			\ {
				\ 'word': image,
				\ 'kind': 'docker/image',
				\ 'action_word': data[2]
			\ }
		\ )
	endfor
	return result
endfunction

function! unite#sources#docker_images#define()
	return s:unite_source
endfunction
