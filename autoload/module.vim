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

" Compilation Plugin
" save the output of the compiled file in a list of lines
" for each line, grab the file position and error text
" present this information in the gutter
let s:errors = {}
function! Make()
    let s:errors = {}
    sign unplace *
    sign define MakeError   text=Er texthl=Error
    sign define MakeWarning text=Wa texthl=Warning
    let l:output = systemlist("make")
    let l:errors = []
    for l:line in l:output
        if l:line =~ "error"
            call add(l:errors, l:line)
        elseif l:line =~ "warning"
            call add(l:errors, l:line)
        endif
    endfor
    let l:signId = 1
    for l:error in l:errors
        let [l:file, l:line, l:column, l:type, l:message] = split(l:error, ":")
        let l:sign = "MakeError"
        if l:type =~ "error"
            let l:sign = "MakeError"
        elseif l:type =~ "warning"
            let l:sign = "MakeWarning"
        endif
        execute "sign place " . l:signId . " line=" . l:line .
              \ " name=" . l:sign . " file=" . l:file
        let l:signId = l:signId + 1
        let s:errors[l:line] = l:message
    endfor
    call UpdateErrorModeline()
endfunction

function! UpdateErrorModeline()
    let l:line = line(".")
    if has_key(s:errors, l:line)
        echom get(s:errors, l:line)
    else
        echom ""
    endif
endfunction

autocmd CursorMoved * call UpdateErrorModeline()

map <C-m> :call Make()<CR>
" end Compilation Plugin

let s:Kursor = module#load("bvp/bvpt/bvpt_cursor")
let s:kursor = s:Kursor.new(41, 2)
"call s:kursor.setVisible(1)

let s:snippetUtil = module#load("bvp/bvpu/bvpu_snippetutil")
let s:comment   = '"'
let s:header    = s:snippetUtil.fileHeader("test.js", "JavaScript", s:comment, 79)
let s:purpose   = s:snippetUtil.purpose(s:comment)
let s:banner    = s:snippetUtil.testBanner("HELPER CLASSES", s:comment, 79)
let s:copyright = s:snippetUtil.copyright(s:comment, 79)

let s:snippet = join([s:header, s:purpose, s:banner, s:copyright], "\r")

function! InsertSnippet()
    let l:window = winsaveview()
    let l:line = line(".")
    echom l:line
    let l:lines = s:snippetUtil.getLines(s:snippet)
    call append(l:line - 1, l:lines)
    call winrestview(l:window)
endfunction

map <C-i> :call InsertSnippet()<CR>
