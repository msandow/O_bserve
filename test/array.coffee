require('coffee-script/register')
require('mocha')
expect = require('chai').expect
_O = require('./../src/O_bserve.coffee')

describe('Array', ->

  describe('Getters', ->
  
    it('Should have correct length', ->
      _to = _O.create(
        foo: _O.array([1,2,3,4])
      )

      expect(_to.foo).to.have.length(4)
      
    )
    
  )

)