function! BVPU_CLASS(Load)

                             " ===========
                             " class Class
                             " ===========

    let l:class = {}

    " BOOTSTRAP
    function l:class.undefined() dict
        throw 'Error: function is undefined'
    endfunction

    " CLASS ACCESSORS
    let l:class.specify = l:class.undefined
        " @Signature: () => ClassSpec
        " Return the empty base specification for a class.

    let l:class.create  = l:class.undefined
        " @Signature: (ClassSpec spec) => Class
        " Return the class defined by the specified 'spec'.

    " =========================================================================
    "                              IMPLEMENTATION
    " =========================================================================

    " LOCAL DATA

    " LOCAL FUNCTIONS

    " CLASS ACCESSORS
    function! l:class.specify() dict
        let l:spec         = {}
        let l:spec.init    = self.undefined
        let l:spec.public  = {}
        let l:spec.private = {}
        let l:spec.static  = {}
        return l:spec
    endfunction

    function! l:class.create(spec) dict
        let l:newClass = {}
        let l:newClass.d_definition = {}
        let l:newClass.d_definition.init    = a:spec.init
        let l:newClass.d_definition.private = deepcopy(a:spec.private)
        let l:newClass.d_definition.public  = deepcopy(a:spec.public)
        let l:newClass.d_definition.static  = deepcopy(a:spec.static)
        call extend(l:newClass, a:spec.static)
        function l:newClass.new(...) dict
            let l:object = {}
            call extend(l:object, deepcopy(self.d_definition.private))
            call extend(l:object, deepcopy(self.d_definition.public))
            call call(self.d_definition.init, a:000, l:object)
            return l:object
        endfunction
        return l:newClass
    endfunction

    return l:class
endfunction " BVPU_CLASS
