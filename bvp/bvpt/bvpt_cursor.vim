"bvpt_cursor.vim                                                     -*-VimL-*-

function! BVPT_CURSOR(Load)
    let l:class = a:Load("bvp/bvpu/bvpu_class")

                        " ============
                        " class Cursor
                        " ============

    let l:cursor = l:class.specify()

    " DATA
    let l:cursor.private.d_row    = 0 "The row number of the cursor
    let l:cursor.private.d_column = 0 "The column number of the cursor

    " CLASS MANIPULATORS
    let l:cursor.static.move = l:class.undefined
        " @Signature (Cursor cursor, Int rows, Int columns) => Void
        " Move the specified 'cursor' to the right by the specified number of
        " 'rows' and down by the specified number of 'columns'.

    " CREATORS
    let l:cursor.init          = l:class.undefined
        " @Signature (UInt row, UInt column) => Cursor
        " Construct a new Cursor at the specified 'row' and 'column'.

    " ACCESSORS
    let l:cursor.public.row    = l:class.undefined
        " @Signature () => UInt
        " Return the row number of this Cursor.

    let l:cursor.public.column = l:class.undefined
        " @Signature () => UInt
        " Return the column number of this Cursor.

    let l:cursor.public.visible = l:class.undefined
        " @Signature () => UInt
        " Return 1 if this cursor is visible to the users, otherwise return
        " 0.

    " MANIPULATORS
    let l:cursor.public.setRow     = l:class.undefined
        " @Signature (UInt row) => Void
        " Assign the row of this Cursor to the specified 'row'.

    let l:cursor.public.setColumn  = l:class.undefined
        " @Signature (UInt column) => Void
        " Assign the column of this Cursor to the specified 'column'

    let l:cursor.public.setVisible = l:class.undefined
        " @Signature (UInt visible) => Void
        " Assign the visiblity state of this Cursor.  Visually present this
        " Cursor if the specified 'visible' is 1, otherwise visually hide this
        " Cursor.

    " =========================================================================
    "                              IMPLEMENTATION
    " =========================================================================

    " CLASS MANIPULATORS
    function! l:cursor.static.move(cursor, rows, columns) dict
        let l:row    = a:cursor.row()
        let l:column = a:cursor.column()
        call a:cursor.setRow(l:row + a:rows)
        call a:cursor.setColumn(l:column + a:columns)
    endfunction

    " CREATORS
    function! l:cursor.init(row, column) dict
        let self.d_row       = a:row
        let self.d_column    = a:column
        let self.d_highlight = 0
    endfunction

    " ACCESSORS
    function! l:cursor.public.row() dict
        return self.d_row
    endfunction

    function! l:cursor.public.column() dict
        return self.d_column
    endfunction

    function! l:cursor.public.visible() dict
        return self.d_highlight != 0
    endfunction

    " MANIPULATORS
    function! l:cursor.public.setRow(row) dict
        let self.d_row = a:row
        if self.d_highlight != 0
            call self.setVisible(0)
            call self.setVisible(1)
        endif
    endfunction

    function! l:cursor.public.setColumn(column) dict
        let self.d_column = a:column
        if self.d_highlight != 0
            call self.setVisible(0)
            call self.setVisible(1)
        endif
    endfunction

    function! l:cursor.public.setVisible(visible) dict
        if a:visible == 1
            let l:rowHighlight    = '\%' . self.d_row . 'l'
            let l:columnHighlight = '\%' . self.d_column . 'c'
            let l:highlight       = l:rowHighlight . l:columnHighlight
            let self.d_highlight  = matchadd('Cursor', l:highlight, 9999)
        elseif self.d_highlight != 0
            call matchdelete(self.d_highlight)
            let self.d_highlight = 0
        endif
    endfunction

    return l:class.create(l:cursor)
endfunction " BVPT_CURSOR

