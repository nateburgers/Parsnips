function! BVPU_CLASS(Load)
    let l:class = {}

    function l:class.specify() dict
        let l:spec         = {}
        let l:spec.init    = 0
        let l:spec.public  = {}
        let l:spec.private = {}
        let l:spec.static  = {}
        let l:spec.static.public  = {}
        let l:spec.static.private = {}
        return l:spec
    endfunction

    function l:class.create(spec) dict
        let l:object = {}
        return a:spec
    endfunction

    function l:class.undefined() dict
        throw 'Call to undefined function'
    endfunction

    return l:class
endfunction " BVPU_CLASS
