require('coffee-script/register')
require('mocha')
expect = require('chai').expect
_O = require('./../src/O_bserve.coffee')

describe('Basic', ->

  describe('Setters And Getters', ->
  
    it('Should set described properties', ->
      _to = _O.create(
        foo: _O.property(1)
        bar: _O.property('A')
        f: ()->
          true
      )
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).to.equal(1)      
      expect(_to.bar).to.be.a('string')
      expect(_to.bar).to.equal('A')
      expect(_to.f).to.be.a('function')
      expect(_to.f()).to.equal(true)
      
      _to.foo = 2
      _to.bar = 'B'
      _to.f = null
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).to.equal(2)      
      expect(_to.bar).to.be.a('string')
      expect(_to.bar).to.equal('B')
      expect(_to.f).to.be.a('function')
      expect(_to.f()).to.equal(true)
    )
    
    it('Should not set un-described properties', ->
      _to = _O.create(
        foo: _O.property(2)
      )
      
      _to.bar = 2
      
      expect(_to.bar).to.be.a('undefined')      
    )
    
    it('Should not set constant properties', ->
      _to = _O.create(
        foo: _O.constant(true)
      )
      
      _to.foo = false
      
      expect(_to.foo).to.be.a('boolean')
      expect(_to.foo).to.equal(true)
    )
    
    it('Should change cast properties', ->
      _to = _O.create(
        foo: _O.typed(2)
        bar: _O.typed('foo')
        baz: _O.typed(true)
        cad: _O.typed([1,2,3])
      )
      
      _to.foo = '2.4'
      _to.bar = 2.4
      _to.baz = 0
      _to.cad = 2.4
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).equal(2.4)
      
      expect(_to.bar).to.be.a('string')
      expect(_to.bar).equal('2.4')
      
      expect(_to.baz).to.be.a('boolean')
      expect(_to.baz).equal(false)
      
      expect(_to.cad).to.have.length(3)
      _to.cad = []
      expect(_to.cad).to.have.length(0)
    )
    
  )
  
  describe('Deleters', ->
    it('Should not delete any properties', ->
      _to = _O.create(
        foo: _O.property(1)
        bar: _O.property('A')
      )
      
      delete _to.foo
      delete _to.bar
      
      expect(_to.foo).to.be.a('number')
      expect(_to.foo).to.equal(1)      
      expect(_to.bar).to.be.a('string')
      expect(_to.bar).to.equal('A')
    )
  )

)