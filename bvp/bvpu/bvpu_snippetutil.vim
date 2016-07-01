" bvpu_snippetutil.vim                                               -*-VimL-*-

"@PURPOSE: Provide a namespace for utility functions for generating snippets
"
"@CLASSES:
"   SnippetUtil: Namespace for utility functions for generating snippets
"
"@SEE_ALSO: bvpu_snippet
"
"@DESCRIPTION: This component provides a namespace for utility functions that
"  aid in the generation of snippet text.

if exists('g:BVPU_SNIPPETUTIL_LOADED')
    finish
else
    "let g:BVPU_SNIPPETUTIL_LOADED = 1
endif

function! BVPU_SNIPPETUTIL(Load)
    let l:class = a:Load("bvp/bvpu/bvpu_class")

                              " =============
                              " class SNIPPET
                              " =============

    let l:snippetUtil = l:class.specify()

    " CLASS ACCESSORS
    let l:snippetUtil.static.centerAlign = l:class.undefined
        " @Signature (String text, SnippetOptions options) => String

    let l:snippetUtil.static.fileHeader  = l:class.undefined

    let l:snippetUtil.static.fill        = l:class.undefined

    let l:snippetUtil.static.lines       = l:class.undefined

    let l:snippetUtil.static.padLeft     = l:class.undefined

    let l:snippetUtil.static.padRight    = l:class.undefined

    let l:snippetUtil.static.purpose     = l:class.undefined

    let l:snippetUtil.static.rightAlign  = l:class.undefined


    " =========================================================================
    "                              IMPLEMENTATION
    " =========================================================================

    function! l:snippetUtil.static.centerAlign(text, spacer, columns)
        let l:prefixLength = (a:columns - len(a:text)) / 2
        let l:prefix       = self.fill(a:spacer, l:prefixLength)
        return l:prefix . a:text . l:prefix
    endfunction

    function! l:snippetUtil.static.copyright(comment, columns)
        let l:bannerLength = a:columns - len(a:comment) - 1
        let l:indent = "    "
        let l:year   = strftime("%Y")
        let l:notice = "NOTICE:"
        let l:copyright = l:indent . "Copyright (C) Bloomberg L.P., " . l:year
        let l:rights    = l:indent . "All Rights Reserved."
        let l:property  = l:indent . "Property of Bloomberg L.P. (BLP)"
        let l:license0  = l:indent . "This software is made available solely "
                                 \ . "pursuant to the"
        let l:license1  = l:indent . "terms of a BLP license agreement which "
                                 \ . "governs its use."
        let l:topBanner    = self.fill("-", l:bannerLength)
        let l:bottomBanner = self.centerAlign(" END-OF-FILE ", "-",
                                             \l:bannerLength)
        let l:lines = [l:topBanner, l:notice, l:copyright, l:rights,
                      \l:property, l:license0, l:license1, l:bottomBanner]
        return a:comment . " " . join(l:lines, "\r" . a:comment . " ")
    endfunction

    function! l:snippetUtil.static.fileHeader(fileName, language, comment,
                                             \columns)
        let l:prefix = a:comment . " " . a:fileName
        let l:suffix = "-*-" . a:language . "-*-"
        let l:spaceLength = a:columns
                          \ - len(l:prefix) - len(l:suffix)
        return l:prefix . self.fill(" ", l:spaceLength) . l:suffix
    endfunction

    function! l:snippetUtil.static.fill(text, length)
        let l:repetitions = a:length / len(a:text)
        let l:remainder   = a:length % len(a:text)
        let l:prefix      = repeat(a:text, l:repetitions)
        let l:suffix      = strpart(a:text, 0, l:remainder)
        return l:prefix . l:suffix
    endfunction

    function! l:snippetUtil.static.javascriptModule(innerText)
    endfunction

    function! l:snippetUtil.static.lines(lines)
        return join(a:lines, "\n")
    endfunction

    function! l:snippetUtil.static.purpose(comment)
        let l:purpose     = a:comment . "@PURPOSE: "
        let l:classes     = a:comment . "@CLASSES: "
        let l:seeAlso     = a:comment . "@SEE_ALSO: "
        let l:description = a:comment . "@DESCRIPTION: "
        let l:sections    = [l:purpose, l:classes, l:seeAlso, l:description]
        let l:suffix      = "\r" . a:comment . "\r"
        return join(l:sections, l:suffix) . l:suffix
    endfunction

    function! l:snippetUtil.static.rightAlign(text, columns)
        let l:prefixLength = a:columns - len(a:text) / 2
        let l:prefix       = self.fill(a:spacer, a:columns)
        return l:prefix . a:text
    endfunction

    function! l:snippetUtil.static.getLines(text)
        return split(a:text, "\r")
    endfunction

    function! l:snippetUtil.static.testBanner(text, comment, columns)
        let l:bannerLength = a:columns - len(a:comment) - 1
        let l:title        = self.centerAlign(a:text, " ", l:bannerLength)
        let l:titleLine    = a:comment . l:title
        let l:topBanner    = a:comment . " " . self.fill("=", l:bannerLength)
        let l:bottomBanner = a:comment . " " . self.fill("-", l:bannerLength)
        return join([l:topBanner, l:titleLine, l:bottomBanner], "\r")
    endfunction

    return l:class.create(l:snippetUtil)
endfunction " BVPU_SNIPPETUTIL
