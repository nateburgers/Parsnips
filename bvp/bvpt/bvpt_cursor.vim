"bvpt_cursor.vim                                                     -*-VimL-*-

function! BVPT_CURSOR(Load)
    let l:class = a:Load("bvp/bvpu/bvpu_class")

                        " ============
                        " class Cursor
                        " ============

    let l:cursor = l:class.specify()

    " CREATORS
    let l:cursor.init = l:class.undefined
        " @Signature (UInt row, UInt column) => Cursor
        " Construct a new Cursor at the specified 'row' and 'column'.

    " ACCESSORS
    let l:cursor.public.row = l:class.undefined
        " @Signature () => UInt
        " Return the row number of this Cursor.

    let l:cursor.public.column = l:class.undefined
        " @Signature () => UInt
        " Return the column number of this Cursor.

    " =========================================================================
    "                              IMPLEMENTATION
    " =========================================================================

    " CREATORS
    function! l:cursor.init(row, column) dict
        let self.d_row    = a:row
        let self.d_column = a:column
    endfunction

    " ACCESSORS
    function! l:cursor.public.row() dict
        return self.d_row
    endfunction

    function! l:cursor.public.column() dict
        return self.d_column
    endfunction

    return l:class.create(l:cursor)
endfunction " BVPT_CURSOR

