" module.vim                                                         -*-VimL-*-

"@PURPOSE: Provide a mechanism for loading vim scripts
"
"@CLASSES:
"
"@SEE_ALSO:
"
"@DESCRIPTION:

if exists('g:loaded_module')
    "finish
else
    let g:loaded_module = 1
endif

" LOCAL DATA
let s:home        = expand('<sfile>:p:h:h')
let s:moduleCache = {}

" PRIVATE FUNCTIONS
function! s:eval(filePath)
    execute 'source ' . a:filePath
    let l:functionName = toupper(get(split(get(split(a:filePath, '\.'), -2), '/'), -1))
    let l:Function     = function(l:functionName)
    return l:Function(function('module#load'))
endfunction

" PUBLIC FUNCTIONS
function! module#load(name)
    let l:filePath = s:home . '/' . a:name . '.vim'
    if has_key(s:moduleCache, l:filePath)
        return get(s:moduleCache, l:filePath)
    else
        let l:module = s:eval(l:filePath)
        let s:moduleCache[l:filePath] = l:module
        return l:module
    endif
endfunction

let s:Kursor = module#load("bvp/bvpt/bvpt_cursor")
let s:kursor = s:Kursor.new(41, 2)
"call s:kursor.setVisible(1)

let s:snippetUtil = module#load("bvp/bvpu/bvpu_snippetutil")
let s:comment   = '//'
let s:header    = s:snippetUtil.fileHeader("test.js", "JavaScript", s:comment, 79)
let s:purpose   = s:snippetUtil.purpose(s:comment)
let s:banner    = s:snippetUtil.testBanner("HELPER CLASSES", s:comment, 79)
let s:copyright = s:snippetUtil.copyright(s:comment, 79)

let s:snippet = join([s:header, s:purpose, s:banner, s:copyright], "\r")
for s:line in s:snippetUtil.getLines(s:snippet)
    echom s:line
endfor

function! InsertSnippet()
    let l:line = line(".")
    let l:lines = s:snippetUtil.getLines(s:snippet)
    call append(l:line, l:lines)
endfunction

nmap <C-s> :call InsertSnippet()<CR>
