" Plugin
function! Center(text, filler, width)
    let l:fillerWidth = (a:width - strlen(a:text)) / 2
    let l:filler      = repeat(filler, l:fillerWidth)
    return l:filler . a:text . l:filler
endfunction

" Filetype specific stuff
function! FileName()
    return expand('%:t')
endfunction

function! FileHeader()
    let l:fileName = FileName()
    let l:fileType = '-*-JavaScript-*-'
    let l:paddingLength = 76 - strlen(l:fileName) - strlen(l:fileType)
    let l:padding = repeat(' ', l:paddingLength)
    return ['// ' . l:fileName . l:padding . l:fileType]
endfunction

function! DocumentationHeader(input)
    let l:comment = '//'
    let l:purpose = '//@PURPOSE: '
    let l:classes = '//@CLASSES: '
    let l:class   = '//  ' . a:input . ': ' 
    let l:seeAlso = '//@SEE_ALSO: '
    let l:description = '//@DESCRIPTION: '
    return [l:purpose, l:comment, l:classes, l:class, l:comment, l:seeAlso,
           \l:comment, l:description, l:comment]
endfunction

function! ModuleStart()
    return ['defineModule({', '', '}, function (d) {']
endfunction

function! ClassBanner(input)
    let l:prefix = repeat(' ', 25)
    let l:upper  = l:prefix . '// ' . toupper(a:input)
    let l:banner = l:prefix . '// ' . repeat('=', strlen(a:input))
    return [l:banner, l:upper, l:banner]
endfunction

function! ClassDefinition(input)
    let l:indent = repeat(' ', 4)
    let l:header = 'var ' . a:input . ' = {'
    let l:footer = '};'
    return [l:header, '', l:footer]
endfunction

" Rasterization stuff
function! Concat(lists)
    let l:result = []
    for i in range(0, len(a:lists))
        echom get(get(a:lists, i), 0)
        call extend(l:result, get(a:lists, i))
    endfor
    return l:result
endfunction

function! NewLine()
    return ['']
endfunction

function! Demo(input)
    let l:a = FileHeader() + NewLine() + DocumentationHeader(a:input) + NewLine()
    let l:b = ModuleStart() + NewLine() + ClassBanner(a:input) + NewLine()
    let l:c = ClassDefinition(a:input)
    return l:a + l:b + l:c
endfunction

function! Draw(drawLines)
    for l:lineNumber in range(0, len(a:drawLines) - 1)
        let l:bufferLine = getline(l:lineNumber + 1)
        let l:drawLine   = get(a:drawLines, l:lineNumber)
        let l:lineCount  = line('$')
        if l:lineNumber >= line('$')
            call append(l:lineNumber, l:drawLine)
        elseif l:bufferLine != l:drawLine
            call setline(l:lineNumber + 1, l:drawLine)
        endif
    endfor
endfunction

function! Main()
    let l:input = ''
    let l:lines = Demo(l:input)
    call Draw(l:lines)
    redraw
    let l:key = getchar()
    while 13 != l:key
        let l:character = nr2char(l:key)
        let l:input = l:input . l:character
        let l:lines = Demo(l:input)
        call Draw(l:lines)
        redraw
        let l:key = getchar()
    endwhile
endfunction

nmap <C-i> :call Main()<CR>
