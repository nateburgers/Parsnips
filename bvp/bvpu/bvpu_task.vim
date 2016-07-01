function! BVPU_TASK(Load)
    let l:class = a:Load("bvp/bvpu/bvpu_class")

                         " ==========
                         " class Task
                         " ==========
    let l:task = l:class.specify()

    " CLASS DATA
    let l:task.static.UPDATE_FREQUENCY = 10    " Milliseconds

    " CLASS CREATORS
    let l:task.static.init = l:class.undefined

    " CLASS MANIPULATORS
    let l:task.static.tick = l:class.undefined

    " DATA

    " CREATORS

    " ACCESSORS

    " MANIPULATORS

    " =========================================================================
    "                              IMPLEMENTATION
    " =========================================================================

    " CLASS CREATORS
    function! l:task.static.init() dict
        let s:staticSelf = self
        autocmd   User TaskTick call s:staticSelf.tick()
        doautocmd User TaskTick
    endfunction

    " CLASS MANIPULATORS
    let s:tick = 0
    function! l:task.static.tick() dict
        let s:tick = s:tick + 1
        echom "yay " . s:tick
    endfunction

    " CREATORS

    " ACCESSORS

    " MANIPULATORS

    return l:class.create(l:task)
endfunction
