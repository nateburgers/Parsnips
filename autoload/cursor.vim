" Value Semantic representation of a Cursor
" Maintainer: Nathan Burgers <nburgers@bloomberg.net>
" License:    MIT

" INCLUDE GUARD
"if exists('g:loaded_cursor')
"    finish
"endif
"let g:loaded_cursor = 1

" class IOList
function IOList_New()
endfunctio

                         " ==============
                         " INITIALIZATION
                         " ==============

function! s:init()
    highlight Cursor ctermfg=7 ctermbg=8
endfunction
call s:init()

" LOCAL FUNCTIONS
function! s:matchLine(number)
    return '\%' . a:number . 'l'
endfunction

function! s:matchColumn(number)
    return '\%' . a:number . 'c'
endfunction

function! s:addCursorMatch(cursor)
    let l:line   = a:cursor.d_line
    let l:column = a:cursor.d_column
    let l:cursor = s:matchLine(l:line) . s:matchColumn(l:column)
    return matchadd('Cursor', l:cursor, 99999)
endfunction

                         " ============
                         " class CURSOR
                         " ============

" CREATORS
function! cursor#new(line, column)
    let l:self          = {}
    let l:self.d_line   = a:line
    let l:self.d_column = a:column
    let l:self.d_match  = s:addCursorMatch(l:self)
    return self
endfunction

function! cursor#delete(cursor)
    call matchdelete(a:cursor.d_match)
endfunction

" ACCESSORS
function! cursor#line(cursor)
    return a:cursor.d_line
endfunction

function! cursor#column(cursor)
    return a:cursor.d_column
endfunction

" MANIPULATORS
function! cursor#draw(cursor)
endfunction

" Usage
let s:cursor = cursor#new(3, 3)
