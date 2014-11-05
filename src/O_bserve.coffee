_O =
  _modifiers:
    
    alias: (originalTree, key) ->
      originalTree[key].O_bserve_desc.enumerable = false
      originalTree['___'+key] = originalTree[key].O_bserve_desc
      originalTree
    
    toMimic: (originalTree, key) ->
      originalTree = _O._modifiers.alias(originalTree, key)
      originalTree[key] = 
        enumerable: true
        configurable: false
        get: ->
          @['___'+key]
        set: (v) ->
          o = @['___'+key]
          @['___'+key] = v
          @['__onValueUpdate__'](o,v)
      originalTree
      
    toTyped: (originalTree, key) ->
      originalTree = _O._modifiers.alias(originalTree, key)
      originalTree[key] = 
        enumerable: true
        configurable: false
        get: ->
          @['___'+key]
        set: (v) ->
          o = @['___'+key]
          switch typeof o
            when 'number'
              v = Number(v)
            when 'boolean'
              v = Boolean(v)
            when 'string'
              v = String(v)
          if typeof o is typeof v
            @['___'+key] = v
            @['__onValueUpdate__'](o,v)
          
          
      originalTree
    
    clean: (originalTree, key) ->
      originalTree[key] = originalTree[key].O_bserve_desc
      originalTree

  create: (props) ->
    for own k,v of props
      if v.O_bserve_desc is undefined
        if Array.isArray(v)
          props[k] = _O.array(v)
        else if typeof v is 'object' and v.___array is undefined
          props[k] = _O.create(v)
        else
          props[k] = _O.property(v)
        
  
    for own k,v of props
      if v.O_bserve_mod
        props = v.O_bserve_mod(props, k)

    props['__onValueUpdate__'] =
      configurable: false
      enumerable: false
      writable: true
      value: (prev, curr) ->
        return

    ob = Object.create(Object.prototype, props)

    Object.seal(ob)
    
    ob

  property: (val) ->
    O_bserve_desc:
      value:val
      configurable: false
      writable: typeof val isnt 'function'
      enumerable: true
    O_bserve_mod: _O._modifiers.toMimic
      

  computed: (func) ->
    O_bserve_desc:
      configurable: false
      enumerable: false
      get: func
    O_bserve_mod: _O._modifiers.clean


  constant: (val) ->
    O_bserve_desc:
      value:val
      configurable: false
      writable: false
      enumerable: true
    O_bserve_mod: _O._modifiers.clean


  typed: (val) ->
    O_bserve_desc:
      value:val
      configurable: false
      writable: true
      enumerable: true
    O_bserve_mod: _O._modifiers.toTyped

  array: (val) ->
    Object.create(Object.prototype, 
      '___array':
        value: val
        enumerable: true
        configurable: false
        writable: false
      length:
        configurable:false
        enumerable: true
        get: () ->
          @['___array'].length
    )
    

  observe: (o, func) ->
    unless Array.isArray(o)
      o = [o]

    for i in o
      if i['__onValueUpdate__']
        i['__onValueUpdate__'] = func
  
  
  unobserve: (o) ->
    unless Array.isArray(o)
      o = [o]

    for i in o
      if i['__onValueUpdate__']
        i['__onValueUpdate__'] = (()->)
        
if typeof module isnt undefined and module.exports
  module.exports = _O