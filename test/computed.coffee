require('coffee-script/register')
require('mocha')
expect = require('chai').expect
_O = require('./../src/O_bserve.coffee')

describe('Computed', ->

  describe('Getters', ->
  
    it('Should get computed properties', ->
      _to = _O.create(
        foo: _O.property(1)
        bar: _O.computed(->
          @foo + 5
        )
      )
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).to.equal(1)
      expect(_to.bar).to.be.a('number')
      expect(_to.bar).to.equal(6)
      
      _to.foo = 2
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).to.equal(2)      
      expect(_to.bar).to.be.a('number')
      expect(_to.bar).to.equal(7)
    )
  )
  
  describe('Setters', ->
    it('Should not set computed properties', ->
      _to = _O.create(
        foo: _O.computed(->
          10
        )
        bar: _O.computed(->
          @foo + 1
        )
      )
      
      _to.foo = null
      _to.bar = null
      
      expect(_to.foo).to.be.a('number')
      expect(_to.bar).to.be.a('number')
      expect(_to.foo).to.equal(10)
      expect(_to.bar).to.equal(11)
    )
  )
  
  describe('Deleters', ->
    it('Should not delete computed properties', ->
      _to = _O.create(
        foo: _O.computed(->
          10
        )
        bar: _O.computed(->
          @foo + 1
        )
      )
      
      delete _to.foo
      delete _to.bar
      
      expect(_to.foo).to.be.a('number')
      expect(_to.bar).to.be.a('number')
      expect(_to.foo).to.equal(10)
      expect(_to.bar).to.equal(11)
    )
  )

)