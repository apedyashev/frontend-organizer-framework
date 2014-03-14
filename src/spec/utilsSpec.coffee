describe "Rrs.mixOf", ->
  it "added mix in another classes to a new class", ->
    class Mixin1
      mixin1Method: ->
      mixin1Prop: 1
    class Mixin2
      mixin2Method: ->
      mixin2Prop: 2
    class Mixin3
      mixin3Method: ->
      mixin3Prop: 3

    class ConstructedClass extends Rrs.mixOf Mixin1, Mixin2, Mixin3
    constructedClassInst = new ConstructedClass

    expect(constructedClassInst.mixin1Method).toBeDefined()
    expect(constructedClassInst.mixin2Method).toBeDefined()
    expect(constructedClassInst.mixin3Method).toBeDefined()

    expect(constructedClassInst.mixin1Prop).toEqual(1)
    expect(constructedClassInst.mixin2Prop).toEqual(2)
    expect(constructedClassInst.mixin3Prop).toEqual(3)

describe "Rrs.Obj", ->
  describe "provides the getClass() function that", ->
    it "returns class name when instance of class is passed", ->
      obj = UserPanelWidget.create()
      expect( Rrs.Obj.getClass(obj) ).toEqual 'UserPanelWidget'

    it "returns class name when class is passed", ->
      expect( Rrs.Obj.getClass(UserPanelWidget) ).toEqual 'UserPanelWidget'

    it "returns result of typeof operation", ->
      expect( Rrs.Obj.getClass('some sting') ).toEqual 'string'
      expect( Rrs.Obj.getClass(1) ).toEqual 'number'
      expect( Rrs.Obj.getClass(1.1) ).toEqual 'number'
      expect( Rrs.Obj.getClass([1, 4]) ).toEqual 'Array'
      expect( Rrs.Obj.getClass({}) ).toEqual 'Object'


  describe "provides the extend() function that", ->
    it "extends object with properties", ->
      object =
        prop1: 1
        prop2: 2
      params =
        prop3: 3
        prop4: 4
      Rrs.Obj.extend object, params

      expect(object.prop1).toEqual 1
      expect(object.prop2).toEqual 2
      expect(object.prop3).toEqual 3
      expect(object.prop4).toEqual 4

    it "extends object with functions", ->
      fn1 = -> 1
      fn2 = -> 2
      fn3 = -> 3
      fn4 = -> 4
      object =
        fn1: fn1
        fn2: fn2
      params =
        fn3: fn3
        fn4: fn4
      Rrs.Obj.extend object, params

      expect(object.fn1).toEqual fn1
      expect(object.fn2).toEqual fn2
      expect(object.fn3).toEqual fn3
      expect(object.fn4).toEqual fn4

     it "extends object with both props and functions", ->
      fn1 = -> 1
      fn2 = -> 2
      fn3 = -> 3
      fn4 = -> 4
      object =
        fn1: fn1
        fn2: fn2
        prop1: 1
        prop2: 2
      params =
        fn3: fn3
        fn4: fn4
        prop3: 3
        prop4: 4
      Rrs.Obj.extend object, params

      expect(object.prop1).toEqual 1
      expect(object.prop2).toEqual 2
      expect(object.prop3).toEqual 3
      expect(object.prop4).toEqual 4

      expect(object.fn1).toEqual fn1
      expect(object.fn2).toEqual fn2
      expect(object.fn3).toEqual fn3
      expect(object.fn4).toEqual fn4

    it "creates empty object and copies params to it if undefined is passed", ->
      params = 
        prop3: 3
        prop4: 4
      object = undefined
      object = Rrs.Obj.extend object, params
      expect(object.prop3).toEqual 3
      expect(object.prop4).toEqual 4

    it "creates empty object and copies params to it if null is passed", ->
      params = 
        prop3: 3
        prop4: 4
      object = null
      object = Rrs.Obj.extend object, params
      expect(object.prop3).toEqual 3
      expect(object.prop4).toEqual 4

    it "doesn't change object if params is null", ->
      object = {a: 1}
      object = Rrs.Obj.extend object, null
      expect(object).toEqual {a: 1}

    it "doesn't change object if params is undefined", ->
      object = {a: 12}
      object = Rrs.Obj.extend object, undefined
      expect(object).toEqual {a: 12}




  describe "provides the isString() function that", ->
    it "returns true if string is passed", ->
      expect( Rrs.Obj.isString("365") ).toEqual true

    it "returns false if a number is passed", ->
      expect( Rrs.Obj.isString(1) ).toEqual false

    it "returns false if an object is passed", ->
      expect( Rrs.Obj.isString({}) ).toEqual false

    it "returns false if a function is passed", ->
      expect( Rrs.Obj.isString( -> ) ).toEqual false


  describe "provides the isObject() function that", ->
    it "returns true if object is passed", ->
      expect( Rrs.Obj.isObject({}) ).toEqual true

    it "returns false if a number is passed", ->
      expect( Rrs.Obj.isObject(1) ).toEqual false

    it "returns false if a string is passed", ->
      expect( Rrs.Obj.isObject("123") ).toEqual false

    it "returns false if a function is passed", ->
      expect( Rrs.Obj.isString( -> ) ).toEqual false


  describe "provides the isFunction() function that", ->
    it "returns true if a function is passed", ->
      expect( Rrs.Obj.isFunction( -> ) ).toEqual true

    it "returns false if object is passed", ->
      expect( Rrs.Obj.isFunction({}) ).toEqual false

    it "returns false if a number is passed", ->
      expect( Rrs.Obj.isFunction(1) ).toEqual false

    it "returns false if a string is passed", ->
      expect( Rrs.Obj.isFunction("123") ).toEqual false


  describe "provides the isJQeryObject() function that", ->
    it "returns true if a jQuery is passed", ->
      expect( Rrs.Obj.isJQeryObject( $('body') ) ).toEqual true

    it "returns false if a function is passed", ->
      expect( Rrs.Obj.isJQeryObject( -> ) ).toEqual false

    it "returns false if object is passed", ->
      expect( Rrs.Obj.isJQeryObject({}) ).toEqual false

    it "returns false if a number is passed", ->
      expect( Rrs.Obj.isJQeryObject(1) ).toEqual false

    it "returns false if a string is passed", ->
      expect( Rrs.Obj.isJQeryObject("123") ).toEqual false
