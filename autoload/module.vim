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

let s:Cursor = module#load("bvp/bvpt/bvpt_cursor")
echom s:Cursor.row()
