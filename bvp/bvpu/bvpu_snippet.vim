" bvpu_snippet.vim                                                   -*-VimL-*-

"@PURPOSE: Provide an protocol for snippets
"
"@CLASSES:
"   Snippet: Protocol for the generation of snippets
"
"@SEE_ALSO: bvpu_snippetvalue, bvpu_snippetutil
"
"@DESCRIPTION: This component defines a protocol, Snippet, for the incremental
"  generation of snippet text.

if exists('g:BVPU_SNIPPET_LOADED')
    finish
else
    "let g:BVPU_SNIPPET_LOADED = 1
endif

function! BVPU_SNIPPET(Load)
    let l:class = Load("bvp/bvpu/bvpu_class")

                              " =============
                              " class SNIPPET
                              " =============

    let l:snippet = l:class.specify()

    " CREATORS
    let l:snippet.init = l:class.undefined

    " ACCESSORS
    let l:snippet.compute = l:class.undefined

    " MANIPULATORS

    return l:class.create(l:snippet)
endfunction
